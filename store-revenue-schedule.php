<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gb-generator-1";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: "
        . $conn->connect_error);
}

$json = json_decode(file_get_contents("php://input"));
$sequence_data = $json->sequence_data;
foreach ($sequence_data as $sequence) {


    // $text = isset($sequence->text) ? $sequence->text : null;
    // $allocation = isset($sequence->allocation) ? $sequence->allocation : null;

    // print_r("SELECT * FROM sequence WHERE credit_sequence=" . $sequence->sequence_id . " or debit_sequence=" . $sequence->sequence_id);
    if (isset($sequence->text) && $sequence->text != '') {
        $qu = "SELECT * FROM sequence WHERE ((head_of_account='" . $sequence->text . "'))";
    } else if (isset($sequence->allocation) && $sequence->allocation != '') {
        $qu = "SELECT * FROM sequence WHERE ((allocation='" . $sequence->allocation . "'))";
    }
    echo "<pre>";
    print_r("******* Select Query Starts *********");
    print_r($qu);
    print_r("******* Select Query Ends *********");
    echo "</pre>";
    $seqDatas = mysqli_fetch_all($conn->query($qu), MYSQLI_ASSOC);
    // if (!$query) {
    //     die('Error: ' . mysqli_error($con));
    // }
    // print_r(mysqli_num_rows($query));
    // print_r($sequence->sequence_id);
    if (count($seqDatas) > 0) {
        // print_r($sequence->sequence_id . '\n');
        foreach ($seqDatas as $seqData) {
            try {
                $sequence_id = $seqData['id'];

                // throw new Exception($doesDataExist);
                $sql = "SELECT * FROM sequence_data WHERE sequence_id=" . $sequence_id . " and custom_year_month =" . $json->year_month;
                echo "<pre>";
                print_r("******* Select Query Starts *********");
                print_r($sql);
                print_r("******* Select Query Ends *********");
                echo "</pre>";
                $doesDataExist = $conn->query($sql);

                $credit_amount = 0;
                $debit_amount = 0;
                if (isset($seqData['credit_sequence']) && $seqData['credit_sequence'] != NULL) {
                    $credit_amount = $sequence->amount;
                }
                if (isset($seqData['debit_sequence']) && $seqData['debit_sequence'] != NULL) {
                    $debit_amount = $sequence->amount;
                }
                if ($seqData['should_include_in_II_part'] == 1 || $seqData['should_include_in_III_part'] == 1) {
                    $credit_amount = $sequence->credit;
                    $debit_amount = $sequence->debit;
                }

                if ($doesDataExist->num_rows <= 0) {
                    $q = "INSERT INTO `sequence_data` (`id`,`sequence_id`, `custom_year_month`,`for_the_month_credit_amount`, `for_the_month_debit_amount`, `created_at`, `updated_at`) VALUES (null, $sequence_id, $json->year_month, $credit_amount, $debit_amount, current_timestamp(), current_timestamp())";
                    echo "<pre>";
                    print_r("******* Insert Query Starts *********");
                    print_r($q);
                    print_r("******* Insert Query Ends *********");
                    echo "</pre>";
                    $ar = $conn->query($q);
                } else {
                    $q = "UPDATE `sequence_data` SET";
                    $r = '';
                    if (isset($credit_amount) && $credit_amount != 0) {
                        $r .= " `for_the_month_credit_amount` = $credit_amount";
                    }
                    if (isset($debit_amount) && $debit_amount != 0) {
                        if($r != ''){
                            $r .= ',';
                        }
                        $r .= " `for_the_month_debit_amount` = $debit_amount";
                    }
                    if (!empty($r)) {
                        $q .= $r;
                        $q .= " WHERE `sequence_id` = $sequence_id and `custom_year_month` = $json->year_month";
                        echo "<pre>";
                        print_r("******* Update Query Starts *********");
                        print_r($q);
                        print_r("******* Update Query Ends *********");
                        echo "</pre>";
                        $ar = $conn->query($q);
                    }
                }
                if (isset($ar) && $ar === FALSE) {
                    throw new Exception($conn->error);
                }
            } catch (Exception $e) {
                //...
                printf("Error message: %s\n", $conn->error);
            }
        }
    }
}
