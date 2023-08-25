<?php
include_once('conn.php');
$json = json_decode(file_get_contents("php://input"));

$sequence_data = $json->sequence_data;
foreach ($sequence_data as $sequence) {


    // print_r("SELECT * FROM sequence WHERE credit_sequence=" . $sequence->sequence_id . " or debit_sequence=" . $sequence->sequence_id);
    $qu = "SELECT * FROM sequence WHERE (credit_sequence='" . $sequence->sequence_id . "' or debit_sequence='" . $sequence->sequence_id . "') and can_be_found_in_schedule = 0 and should_only_carry_forward = 0";
    // echo "<pre>";
    // print_r("******* Select Query Starts *********");
    // print_r($qu);
    // print_r("******* Select Query Ends *********");
    // echo "</pre>";
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
                $sql = "SELECT * FROM sequence_data WHERE sequence_id=" . $sequence_id . " and custom_year_month =" . $sequence->year_month;
                // echo "<pre>";
                // print_r("******* Select Query Starts *********");
                // print_r($sql);
                // print_r("******* Select Query Ends *********");
                // echo "</pre>";
                $doesDataExist = $conn->query($sql);

                $credit_amount = 0;
                $debit_amount = 0;
                if ($seqData['credit_sequence'] == $sequence->sequence_id) {
                    $credit_amount = $sequence->for_the_month;
                    if (in_array($sequence->sequence_id, [12960, 12965])) {
                        $credit_amount = $credit_amount / 2;
                    }
                }
                if ($seqData['debit_sequence'] == $sequence->sequence_id) {
                    $debit_amount = $sequence->for_the_month;
                }
                if ($doesDataExist->num_rows <= 0) {
                    $q = "INSERT INTO `sequence_data` (`id`,`sequence_id`, `custom_year_month`,`for_the_month_credit_amount`, `for_the_month_debit_amount`, `created_at`, `updated_at`) VALUES (null, $sequence_id, $sequence->year_month, $credit_amount, $debit_amount, current_timestamp(), current_timestamp())";
                    // echo "<pre>";
                    // print_r("******* Insert Query Starts *********");
                    // print_r($q);
                    // print_r("******* Insert Query Ends *********");
                    // echo "</pre>";
                    $ar = $conn->query($q);
                } else {
                    $q = "UPDATE `sequence_data` SET";
                    $r = '';
                    if (isset($credit_amount) && $credit_amount != 0) {
                        $r .= " `for_the_month_credit_amount` = $credit_amount";
                    }
                    if (isset($debit_amount) && $debit_amount != 0) {
                        $r .= " `for_the_month_debit_amount` = $debit_amount";
                    }
                    if (!empty($r)) {
                        $q .= $r;
                        $q .= " WHERE `sequence_id` = $sequence_id and `custom_year_month` = $sequence->year_month";
                        // echo "<pre>";
                        // print_r("******* Update Query Starts *********");
                        // print_r($q);
                        // print_r("******* Update Query Ends *********");
                        // echo "</pre>";
                        $ar = $conn->query($q);
                    }
                }
                if (isset($ar) && $ar === FALSE) {
                    throw new Exception($conn->error);
                }
            } catch (Exception $e) {
                //...
                $response = ['status' => 'error', 'status_code' => 500, 'message' => 'Something Went Wrong'];
                header('Content-type: application/json');
                http_response_code(500);
                echo json_encode($response);
                printf("Error message: %s\n", $conn->error);
            }
        }
    }
    
}
$response = ['status' => 'success', 'status_code' => 200, 'message' => 'File Uploaded Successfully'];
header('Content-type: application/json');
http_response_code(200);
echo json_encode($response);
