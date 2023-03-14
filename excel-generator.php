<?php
require "vendor/autoload.php";

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

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

// TODO Need to write logic of creating a new file if it does not exist or if it exists, writing it in the same.
$exists = file_exists('gb-generator-automated.xlsx');
// if(!$exists) {
// $spreadsheet = new Spreadsheet();
// } else {
//     $spreadsheet = \PhpOffice\PhpSpreadsheet\IOFactory::load("gb-generator-automated.xlsx");
// }
$json = json_decode(file_get_contents("php://input"));
$spreadsheet = new Spreadsheet();
$writer = new Xlsx($spreadsheet);
$sheet = $spreadsheet->getActiveSheet();

$month = strtoupper($json->month_full);
$year = $json->year;
$month_fig = $json->month;
$is_final = $json->is_final;
$month_year = $month . '-' . $year;
// TODO make the month and year dynamic


// $prev_fin_year = date('d/m/Y', '01//' . ($year - 1));
// $curr_fin_year = date('d/m/Y', '01/' . $month_fig . '/' . ($year));


$sheet->mergeCells('A1:J1');
$sheet->setCellValue("A1", "MONTH " . $month_year);
$sheet->getStyle('A1')->getFont()->setBold(true);
$sheet->getStyle('A1')->getAlignment()->setHorizontal('center');

// NOTE Sr. No.
$sheet->mergeCells('A2:A3');
$sheet->setCellValue("A2", "Sr. No.");
$sheet->getStyle('A2')->getFont()->setBold(true);
$sheet->getStyle('A2')->getAlignment()->setHorizontal('center');

// SECTION Sequence
$sheet->mergeCells('B2:C2');
$sheet->setCellValue("B2", "Sequence"); // TODO Dynamic
$sheet->getStyle('B2')->getFont()->setBold(true);
$sheet->getStyle('B2')->getAlignment()->setHorizontal('center');

// NOTE Debit
$sheet->setCellValue("B3", "DEBIT");
$sheet->getStyle('B3')->getFont()->setBold(true);
$sheet->getStyle('B3')->getAlignment()->setHorizontal('center');

// NOTE Credit
$sheet->setCellValue("C3", "CREDIT");
$sheet->getStyle('C3')->getFont()->setBold(true);
$sheet->getStyle('C3')->getAlignment()->setHorizontal('center');

// NOTE Autosizing Debit & Credit Cell with Opening Balance Cell
$value =  $sheet->getCell('B2')->getValue();
$width = (mb_strwidth($value) + 8) / 2; //Return the width of the string + 4 for left & right padding
$sheet->getColumnDimension('B')->setWidth($width);
$sheet->getColumnDimension('C')->setWidth($width);
// !SECTION 

// NOTE Head of A/Cs
$sheet->mergeCells('D2:D3');
$sheet->setCellValue("D2", "Head of A/Cs");
$sheet->getStyle('D2')->getFont()->setBold(true);
$sheet->getStyle('D2')->getAlignment()->setHorizontal('center');

// SECTION OPENING BALANCE
$sheet->mergeCells('E2:F2');
$sheet->setCellValue("E2", "OPENING BALANCE (as on " . $json->start_date . ")"); // TODO Dynamic
$sheet->getStyle('E2')->getFont()->setBold(true);
$sheet->getStyle('E2')->getAlignment()->setHorizontal('center');

// NOTE Debit
$sheet->setCellValue("E3", "DEBIT");
$sheet->getStyle('E3')->getFont()->setBold(true);
$sheet->getStyle('E3')->getAlignment()->setHorizontal('center');

// NOTE Credit
$sheet->setCellValue("F3", "CREDIT");
$sheet->getStyle('F3')->getFont()->setBold(true);
$sheet->getStyle('F3')->getAlignment()->setHorizontal('center');

// NOTE Autosizing Debit & Credit Cell with Opening Balance Cell
$value =  $sheet->getCell('E2')->getValue();
$width = (mb_strwidth($value) + 4) / 2; //Return the width of the string + 4 for left & right padding
$sheet->getColumnDimension('E')->setWidth($width);
$sheet->getColumnDimension('F')->setWidth($width);
// !SECTION 

// SECTION FOR THE MONTH
$sheet->mergeCells('G2:H2');
$sheet->setCellValue("G2", "FOR THE MONTH " . $month_year); // TODO Dynamic
$sheet->getStyle('G2')->getFont()->setBold(true);
$sheet->getStyle('G2')->getAlignment()->setHorizontal('center');

// NOTE Debit
$sheet->setCellValue("G3", "DEBIT");
$sheet->getStyle('G3')->getFont()->setBold(true);
$sheet->getStyle('G3')->getAlignment()->setHorizontal('center');

// NOTE Credit
$sheet->setCellValue("H3", "CREDIT");
$sheet->getStyle('H3')->getFont()->setBold(true);
$sheet->getStyle('H3')->getAlignment()->setHorizontal('center');

// NOTE Autosizing Debit & Credit Cell with FOR THE MONTH Cell
$value =  $sheet->getCell('G2')->getValue();
$width = (mb_strwidth($value) + 4) / 2; //Return the width of the string + 4 for left & right padding
$sheet->getColumnDimension('G')->setWidth($width);
$sheet->getColumnDimension('H')->setWidth($width);
// !SECTION

// SECTION TO END OF MONTH
$sheet->mergeCells('I2:J2');
$sheet->setCellValue("I2", "TO END OF MONTH (as on " . $json->end_date . ")"); // TODO Dynamic
$sheet->getStyle('I2')->getFont()->setBold(true);
$sheet->getStyle('I2')->getAlignment()->setHorizontal('center');

// NOTE Debit
$sheet->setCellValue("I3", "DEBIT");
$sheet->getStyle('I3')->getFont()->setBold(true);
$sheet->getStyle('I3')->getAlignment()->setHorizontal('center');

// NOTE Credit
$sheet->setCellValue("J3", "CREDIT");
$sheet->getStyle('J3')->getFont()->setBold(true);
$sheet->getStyle('J3')->getAlignment()->setHorizontal('center');

// NOTE Autosizing Debit & Credit Cell with TO END OF MONTH Cell
$value =  $sheet->getCell('I2')->getValue();
$width = (mb_strwidth($value) + 4) / 2; //Return the width of the string + 4 for left & right padding
$sheet->getColumnDimension('I')->setWidth($width);
$sheet->getColumnDimension('J')->setWidth($width);
// !SECTION

// NOTE Auto Size Columns
$spreadsheet->getActiveSheet()->getColumnDimension('D')->setWidth(76.5);

try {
    $json->fin_month = $json->month;
    if ($is_final) {
        $json->month = $json->month + 1;
    }
    $current_month = str_pad($json->month, 2, '0', STR_PAD_LEFT);
    $previous_month = str_pad($json->month - 1, 2, '0', STR_PAD_LEFT);
    $current_year = $json->year;
    $json->month = str_pad($json->month, 2, '0', STR_PAD_LEFT);
    $current_month_year_digit = $current_year . $current_month;
    if ($previous_month == 00) {
        $previous_year = strval(intval($current_year - 1));
        $previous_month = "12";
        $previous_month_year_digit = $previous_year . $previous_month;
    } else {
        $previous_month_year_digit = $current_year . $previous_month;
    }
    // $qr = 'SELECT id as sid, head_of_account, debit_sequence, credit_sequence, should_debit_be_zero_if_negative, should_credit_be_zero_if_negative, should_debit_be_zero_if_positive, should_credit_be_zero_if_positive,
    // case should_only_carry_forward
    //         when "0" then (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $previous_month_year_digit . '")
    //         when "1" then (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "0")
    // end as opening_balance_debit_amount,
    // case should_only_carry_forward
    //         when "0" then (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $previous_month_year_digit . '")
    //         when "1" then (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "0")
    // end as opening_balance_credit_amount,
    // case should_only_carry_forward
    //         when "0" then (select for_the_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '")
    //         when "1" then (select for_the_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "0")
    // end as for_the_month_debit_amount, 
    // case should_only_carry_forward
    //         when "0" then (select for_the_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '")
    //         when "1" then (select for_the_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "0")
    // end as for_the_month_credit_amount,
    // (select id from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '") as seq_data_id
    // FROM `sequence`  where sequence.should_include_in_II_part = 0 order by ISNULL(credit_sequence), credit_sequence asc, ISNULL(debit_sequence), debit_sequence asc';

    if ($json->fin_month <= 3) {
        $cur_fin_year = $json->year;
        $pre_fin_year = $json->year - 1;
    } else {
        $cur_fin_year = $json->year + 1;
        $pre_fin_year = $json->year;
    }
    echo "<pre>";
    echo "Current Year: " . $cur_fin_year;
    echo "Previous Year: " . $pre_fin_year;
    echo "</pre>";
    $qr = "((SELECT id as sid, head_of_account, debit_sequence, credit_sequence, should_debit_be_zero_if_negative, should_credit_be_zero_if_negative, should_debit_be_zero_if_positive, should_credit_be_zero_if_positive,
    (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $pre_fin_year . "')
    as opening_balance_debit_amount,
    (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $pre_fin_year . "')
    as opening_balance_credit_amount,
    0 as for_the_month_debit_amount, 
    0 as for_the_month_credit_amount, ";
    if ($is_final && $month == 'MAR') {
        // when generating march final we dont need seq_data_id
        $qr .= "null as seq_data_id, ";
    } else {
        $qr .= "(select id from sequence_data where sequence_id = sid and custom_year_month = '" . $cur_fin_year . "') as seq_data_id, ";
    }

    $qr .= "update_frequency
    FROM `sequence` where sequence.update_frequency = 'yearly' and sequence.should_include_in_I_part = 1)  
    UNION all
    SELECT id as sid, head_of_account, debit_sequence, credit_sequence, should_debit_be_zero_if_negative, should_credit_be_zero_if_negative, should_debit_be_zero_if_positive, should_credit_be_zero_if_positive,
    case should_only_carry_forward
            when '0' then (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $previous_month_year_digit . "'";

    if (($is_final && $month == 'MAR') || ($is_final == 0 && $month != 'APR')) {
        $qr .= " and is_final = 0) ";
    } else if ($is_final == 0 && $month == 'APR') {
        $qr .= " and is_final = 1) ";
    }
    $qr .= " when '1' then (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = '0'";
    if ($is_final && $month == 'MAR' || ($is_final == 0 && $month != 'APR')) {
        $qr .= " and is_final = 0) ";
    } else if ($is_final == 0 && $month == 'APR') {
        $qr .= " )";
    }
    $qr .= " end as opening_balance_debit_amount,
    case should_only_carry_forward
            when '0' then (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $previous_month_year_digit . "'";
    if ($is_final && $month == 'MAR' || ($is_final == 0 && $month != 'APR')) {
        $qr .= " and is_final = 0) ";
    } else if ($is_final == 0 && $month == 'APR') {
        $qr .= " and is_final = 1) ";
    }
    $qr .= " when '1' then (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = '0'";
    if ($is_final && $month == 'MAR' || ($is_final == 0 && $month != 'APR')) {
        $qr .= " and is_final = 0) ";
    } else if ($is_final == 0 && $month == 'APR') {
        $qr .= ") ";
    }
    $qr .= " end as opening_balance_credit_amount, ";
    if ($is_final && $month == 'MAR') {
        $qr .= "0";
    } else if ($is_final == 0) {
        $qr .= "(select for_the_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $current_month_year_digit . "' and is_final = 0) ";
    }
    $qr .= " as for_the_month_debit_amount, ";
    if ($is_final && $month == 'MAR') {
        $qr .= "0";
    } else if ($is_final == 0) {
        $qr .= "(select for_the_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $current_month_year_digit . "'  and is_final = 0) ";
    }
    $qr .=  " as for_the_month_credit_amount,";
    if ($is_final && $month == 'MAR') {
        $qr .= "(SELECT id from sequence_data where sequence_id = sid and custom_year_month = '" . $current_month_year_digit . "' and is_final = 1)";
    } else if ($is_final == 0) {
        $qr .= "(SELECT id from sequence_data where sequence_id = sid and custom_year_month = '" . $current_month_year_digit . "' and is_final = 0)";
    }
    $qr .= " as seq_data_id, update_frequency
    FROM `sequence` where (sequence.update_frequency = 'monthly' or sequence.update_frequency IS NULL) and sequence.should_include_in_I_part = 1) ORDER BY FIELD(update_frequency, 'yearly') DESC, ISNULL(credit_sequence), credit_sequence asc, ISNULL(debit_sequence), debit_sequence ASC";
    echo "<pre>";
    echo "Part I Query: \n";
    print_r($qr);
    echo "</pre>";
    // die();
    $seqData = mysqli_fetch_all($conn->query($qr), MYSQLI_ASSOC);
    // $seqData = $seq->fetch_all();
    // $seqData = $seq->free_result();

} catch (Exception $e) {
    //...
    printf("Error message: %s\n", $conn->error);
}

$activeCellNo = 4;
$sr_no = 1;
$grandTotal = [
    'opening_balance_debit_grand_total' => 0,
    'opening_balance_credit_grand_total' => 0,
    'for_the_month_debit_grand_total' => 0,
    'for_the_month_credit_grand_total' => 0,
    'end_of_the_month_debit_grand_total' => 0,
    'end_of_the_month_credit_grand_total' => 0,
];
foreach ($seqData as $seq) {
    setValueStyle($sheet, "A" . $activeCellNo, $sr_no);

    // SECTION Sequence
    setValueStyle($sheet, "B" . $activeCellNo, isset($seq['debit_sequence']) ? $seq['debit_sequence'] : '-');
    setValueStyle($sheet, "C" . $activeCellNo, isset($seq['credit_sequence']) ? $seq['credit_sequence'] : '-');
    // !SECTION

    // SECTION Head Of Account
    setValueStyle($sheet, "D" . $activeCellNo, isset($seq['head_of_account']) ? $seq['head_of_account'] : '-', false, 'left');
    // !SECTION


    // SECTION Opening Balance 
    // NOTE Opening Balance Debit Amount
    $obda = isset($seq['opening_balance_debit_amount']) ? floatval($seq['opening_balance_debit_amount']) : 0;
    setValueStyle($sheet, "E" . $activeCellNo, $obda, true, 'right');
    $grandTotal['opening_balance_debit_grand_total'] += $obda;

    // NOTE Opening Balance Credit Amount
    $obca = isset($seq['opening_balance_credit_amount']) ? floatval($seq['opening_balance_credit_amount']) : 0;
    setValueStyle($sheet, "F" . $activeCellNo, $obca, true, 'right');
    if (!in_array($seq['credit_sequence'], [12960, 12965])) {
        $grandTotal['opening_balance_credit_grand_total'] += $obca;
    }
    // !SECTION Opening Balance 

    // SECTION For The Month 
    // NOTE For The Month Debit Amount
    $ftmda = isset($seq['for_the_month_debit_amount']) ? floatval($seq['for_the_month_debit_amount']) : 0;
    if ($is_final) {
        if (in_array($seq['debit_sequence'], [00007, 77200, 77300])) {
            $ftmda =  -floatval($seq['opening_balance_debit_amount']);
        } else {
            $ftmda = 0;
        }
    }
    setValueStyle($sheet, "G" . $activeCellNo, $ftmda, true, 'right');
    $grandTotal['for_the_month_debit_grand_total'] += $ftmda;

    // NOTE For The Month Credit Amount
    $ftmca = isset($seq['for_the_month_credit_amount']) ? floatval($seq['for_the_month_credit_amount']) : 0;
    if ($is_final) {
        if (in_array($seq['credit_sequence'], [10500, 10600, 10900, 22200, 36200])) {
            $ftmca =  -floatval($seq['opening_balance_credit_amount']);
        } else {
            $ftmca = 0;
        }
    }
    setValueStyle($sheet, "H" . $activeCellNo, $ftmca, true, 'right');
    if (!in_array($seq['credit_sequence'], [12960, 12965])) {
        $grandTotal['for_the_month_credit_grand_total'] += $ftmca;
    }
    // !SECTION For The Month 

    // SECTION End of the Month
    $eotmda = ($obda + $ftmda) - $ftmca;
    if ($seq['should_debit_be_zero_if_negative'] || $seq['should_debit_be_zero_if_positive']) {
        $eotmda = 0;
    }
    setValueStyle($sheet, "I" . $activeCellNo, ($eotmda), true, 'right');

    $grandTotal['end_of_the_month_debit_grand_total'] += $eotmda;

    $eotmca = ($obca + $ftmca) - $ftmda;
    if ($seq['should_credit_be_zero_if_negative'] || $seq['should_credit_be_zero_if_positive']) {
        $eotmca = 0;
    }

    if (!in_array($seq['credit_sequence'], [12960, 12965])) {
        $grandTotal['end_of_the_month_credit_grand_total'] += $eotmca;
    }
    setValueStyle($sheet, "J" . $activeCellNo, ($eotmca), true, 'right');
    if ($is_final && $seq['sid'] != 5) {
        $sql = "SELECT * FROM sequence_data WHERE sequence_id=" . $seq['sid'] . " and custom_year_month =" . $previous_month_year_digit . " and is_final = 1";
        echo "<pre>";
        print_r("******* Select Query Starts *********");
        print_r($sql);
        print_r("******* Select Query Ends *********");
        echo "</pre>";
        $doesDataExist = $conn->query($sql);
        $sequence_id = $seq['sid'];
        if ($doesDataExist->num_rows <= 0) {
            $q = "INSERT INTO `sequence_data` (`id`,`sequence_id`,`for_the_month_credit_amount`, `for_the_month_debit_amount`, `end_of_month_debit_amount`, `end_of_month_credit_amount`, `custom_year_month`, `is_final`, `created_at`, `updated_at`) VALUES (null,$sequence_id , $ftmca, $ftmda, $eotmda, $eotmca, $previous_month_year_digit, 1, current_timestamp(), current_timestamp())";
            echo "<pre>";
            print_r("******* Insert Query Starts *********");
            print_r($q);
            print_r("******* Insert Query Ends *********");
            echo "</pre>";
            $ar = $conn->query($q);
        } else {
            $q = "UPDATE `sequence_data` SET  `for_the_month_credit_amount` = $ftmca,  `for_the_month_debit_amount` = $ftmda, `end_of_month_debit_amount` = $eotmda, `end_of_month_credit_amount` = $eotmca WHERE `sequence_id` = $sequence_id and `custom_year_month` = $previous_month_year_digit and is_final = 1";
            echo "<pre>";
            print_r("******* Update Query Starts *********");
            print_r($q);
            print_r("******* Update Query Ends *********");
            echo "</pre>";
            $ar = $conn->query($q);
        }
    } else {
        $q = "UPDATE `sequence_data` SET `end_of_month_credit_amount` = $eotmca, `end_of_month_debit_amount` = $eotmda WHERE `id` =" . $seq['seq_data_id'];
        $ar = $conn->query($q);
    }
    // !SECTION End of the Month
    $activeCellNo++;
    $sr_no++;
}

if ($is_final) {
    // $tmp_obda = $sheet->getCell('E4')->getValue();
    $tmp_obca = $sheet->getCell('F4')->getValue();
    $old_eotmca = $sheet->getCell('J4')->getValue();
    $tmp_ftmda = abs($grandTotal['for_the_month_debit_grand_total']);
    $tmp_ftmca = abs($grandTotal['for_the_month_credit_grand_total']);
    $tmp_eotmca = ($tmp_obca + $tmp_ftmca) - $tmp_ftmda;
    setValueStyle($sheet, 'G4', abs($tmp_ftmda), true);
    setValueStyle($sheet, 'H4', abs($tmp_ftmca), true);
    setValueStyle($sheet, 'J4', abs($tmp_eotmca), true);
    // $sheet->getCell('I4')->setValue($tmp_eotmda);
    // $sheet->getCell('J4')->setValue($tmp_eotmca);
    $grandTotal['for_the_month_debit_grand_total'] = $grandTotal['for_the_month_debit_grand_total'] + $tmp_ftmda;
    $grandTotal['for_the_month_credit_grand_total'] = $grandTotal['for_the_month_credit_grand_total'] + $tmp_ftmca;
    $grandTotal['end_of_the_month_credit_grand_total']  = $grandTotal['end_of_the_month_credit_grand_total'] + $tmp_eotmca - $old_eotmca;


    $sql = "SELECT * FROM sequence_data WHERE sequence_id=5 and custom_year_month =" . $cur_fin_year . " and is_final = 1";
    echo "<pre>";
    print_r("******* Select Query Starts *********");
    print_r($sql);
    print_r("******* Select Query Ends *********");
    echo "</pre>";
    $doesDataExist = $conn->query($sql);
    $sequence_id = 5;
    if ($doesDataExist->num_rows <= 0) {
        $q = "INSERT INTO `sequence_data` (`id`,`sequence_id`,`for_the_month_credit_amount`, `for_the_month_debit_amount`, `end_of_month_debit_amount`, `end_of_month_credit_amount`, `custom_year_month`, `is_final`, `created_at`, `updated_at`) VALUES (null,$sequence_id , $tmp_ftmca, $tmp_ftmda, 0, $tmp_eotmca, $cur_fin_year, 1, current_timestamp(), current_timestamp())";
        echo "<pre>";
        print_r("******* Insert Query Starts *********");
        print_r($q);
        print_r("******* Insert Query Ends *********");
        echo "</pre>";
        $ar = $conn->query($q);
    } else {
        $q = "UPDATE `sequence_data` SET  `for_the_month_credit_amount` = $tmp_ftmca,  `for_the_month_debit_amount` = $tmp_ftmda, `end_of_month_debit_amount` = 0, `end_of_month_credit_amount` = $tmp_eotmca, `custom_year_month` = $cur_fin_year WHERE `sequence_id` = $sequence_id and `custom_year_month` = $cur_fin_year and is_final = 1";
        echo "<pre>";
        print_r("******* Update Query Starts *********");
        print_r($q);
        print_r("******* Update Query Ends *********");
        echo "</pre>";
        $ar = $conn->query($q);
    }
}

// SECTION Setting Grand total Values
setValueStyle($sheet, "E" . $activeCellNo, $grandTotal['opening_balance_debit_grand_total'], true, 'right');
setValueStyle($sheet, "F" . $activeCellNo, $grandTotal['opening_balance_credit_grand_total'], true, 'right');
setValueStyle($sheet, "G" . $activeCellNo, $grandTotal['for_the_month_debit_grand_total'], true, 'right');
setValueStyle($sheet, "H" . $activeCellNo, $grandTotal['for_the_month_credit_grand_total'], true, 'right');
setValueStyle($sheet, "I" . $activeCellNo, $grandTotal['end_of_the_month_debit_grand_total'], true, 'right');
setValueStyle($sheet, "J" . $activeCellNo, $grandTotal['end_of_the_month_credit_grand_total'], true, 'right');
// setValueStyle($sheet, "J" . $activeCellNo, '=SUM(J4:J75)-J16-J17-J18-J19');
$sheet->mergeCells('A' . $activeCellNo . ':D' . $activeCellNo);
setValueStyle($sheet, "A" . $activeCellNo, "Grand Total", true, 'center');
// !SECTION Setting Grand total Values

$activeCellNo++;

// SECTION for showing differences testing purpose only
$sheet->mergeCells('A' . $activeCellNo . ':D' . $activeCellNo);
setValueStyle($sheet, "A" . $activeCellNo, 'Differences (for testing purpose only)', true, 'center');
setValueStyle($sheet, "F" . $activeCellNo, round($grandTotal['opening_balance_debit_grand_total'] - $grandTotal['opening_balance_credit_grand_total'], 2), true, 'right');
setValueStyle($sheet, "H" . $activeCellNo, round($grandTotal['for_the_month_debit_grand_total'] - $grandTotal['for_the_month_credit_grand_total'], 2), true, 'right');
setValueStyle($sheet, "J" . $activeCellNo, round($grandTotal['end_of_the_month_debit_grand_total'] - $grandTotal['end_of_the_month_credit_grand_total'], 2), true, 'right');
// !SECTION

$activeCellNo++;

$styleArray = [
    'borders' => [
        'allBorders' => [
            'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_MEDIUM,
        ],
    ],
];

$sheet->getStyle($sheet->calculateWorksheetDimension())->applyFromArray($styleArray);

$activeCellNo = $activeCellNo + 2;

// SECTION Signatures
$sheet->mergeCells('E' . ($activeCellNo - 1) . ':F' . $activeCellNo);
$sheet->setCellValue('E' . ($activeCellNo - 1), 'A/C ASSTT. (BKS)');
$sheet->getStyle('E' . $activeCellNo)->getFont()->setBold(true);
$sheet->getStyle('E' . $activeCellNo)->getAlignment()->setHorizontal('center');
// !SECTION Signatures

// SECTION Signatures
$sheet->mergeCells('G' . ($activeCellNo - 1) . ':H' . $activeCellNo);
$sheet->setCellValue('G' . ($activeCellNo - 1), 'SR. SO (BKS)');
$sheet->getStyle('G' . $activeCellNo)->getFont()->setBold(true);
$sheet->getStyle('G' . $activeCellNo)->getAlignment()->setHorizontal('center');
// !SECTION Signatures

// SECTION Signatures
$sheet->mergeCells('I' . ($activeCellNo - 1) . ':J' . $activeCellNo);
$sheet->setCellValue('I' . ($activeCellNo - 1), 'SR. DFM-RJT');
$sheet->getStyle('I' . $activeCellNo)->getFont()->setBold(true);
$sheet->getStyle('I' . $activeCellNo)->getAlignment()->setHorizontal('center');
// !SECTION Signatures

if (!$is_final) {
    // SECTION Deposits
    $activeCellNo = $activeCellNo + 2;
    $depositStartCellNo = 'A' . $activeCellNo;
    $sheet->mergeCells('A' . $activeCellNo . ':H' . $activeCellNo);
    $sheet->setCellValue('A' . $activeCellNo, "STATEMENT SHOWING THE DETAILS FOR THE YEAR " . $year . " - " . ($year + 1) . " BY RAJKOT DIVISION");
    $sheet->getStyle('A' . $activeCellNo)->getFont()->setBold(true);
    $sheet->getStyle('A' . $activeCellNo)->getAlignment()->setHorizontal('center');
    $activeCellNo++;
    $sheet->mergeCells('A' . $activeCellNo . ':H' . $activeCellNo);
    $sheet->setCellValue('A' . $activeCellNo, $month . '-' . $year . ' (Deposite Schedule 19)');
    $sheet->getStyle('A' . $activeCellNo)->getFont()->setBold(true);
    $sheet->getStyle('A' . $activeCellNo)->getAlignment()->setHorizontal('center');

    $activeCellNo++;
    $depositHeaders = ['SR.NO', 'ALLOCATION', '', 'DETAILS OF SUSPENCE', 'OPENING', 'DEBIT', 'CREDIT', 'TOEND'];

    $alphabets = range('A', 'H');
    foreach ($depositHeaders as $key => $value) {
        if ($alphabets[$key] == 'B') {
            $sheet->mergeCells('B' . $activeCellNo . ':C' . $activeCellNo);
            $sheet->setCellValue($alphabets[$key] . $activeCellNo, $value);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getFont()->setBold(true);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getAlignment()->setHorizontal('center');
        } else if ($alphabets[$key] != 'B' && $alphabets[$key] != 'C') {
            $sheet->setCellValue($alphabets[$key] . $activeCellNo, $value);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getFont()->setBold(true);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getAlignment()->setHorizontal('center');
        }
    }

    try {
        $qr2 = 'SELECT id as sid, head_of_account, allocation,
        case should_only_carry_forward 
            when "0" then (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $previous_month_year_digit . '") 
            when "1" then (select end_of_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "0") 
         end as opening_balance,
         case should_only_carry_forward 
            when "0" then (select for_the_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '") 
            when "1" then (select for_the_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "0") 
         end as debit,
         case should_only_carry_forward 
            when "0" then (select for_the_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '") 
            when "1" then (select for_the_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = "0") 
         end as credit,
         (select id from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '") as seq_data_id FROM `sequence` 
         where sequence.should_include_in_II_part = 1 and sequence.can_be_found_in_schedule = 1 order by allocation';
        $depData = mysqli_fetch_all($conn->query($qr2), MYSQLI_ASSOC);
        $total_opening_balance = 0;
        $total_debit = 0;
        $total_credit = 0;
        $total_ending_balance = 0;
        $activeCellNo++;

        foreach ($depData as $key => $value) {

            setValueStyle($sheet, 'A' . $activeCellNo, ($key + 1), true);
            $sheet->mergeCells('B' . $activeCellNo . ':C' . $activeCellNo);

            setValueStyle($sheet, 'B' . $activeCellNo, isset($value['allocation']) && $value['allocation'] != '' ? $value['allocation'] : '-', true);
            setValueStyle($sheet, 'D' . $activeCellNo, isset($value['head_of_account']) ? $value['head_of_account'] : '-', true, 'left');

            $opening_balance = isset($value['opening_balance']) ? floatval($value['opening_balance']) : 0;
            setValueStyle($sheet, 'E' . $activeCellNo, $opening_balance, true, 'right');
            $total_opening_balance += $opening_balance;

            $debit = isset($value['debit']) ? floatval($value['debit']) : 0;
            setValueStyle($sheet, 'F' . $activeCellNo, $debit, true, 'right');
            $total_debit += $debit;

            $credit = isset($value['credit']) ? floatval($value['credit']) : 0;
            setValueStyle($sheet, 'G' . $activeCellNo, $credit, true, 'right');
            $total_credit += $credit;

            $ending_balance = ((floatval($opening_balance) + floatval($credit)) - floatval($debit));
            setValueStyle($sheet, 'H' . $activeCellNo, $ending_balance, true, 'right');
            $total_ending_balance += $ending_balance;

            $q = "UPDATE `sequence_data` SET `end_of_month_credit_amount` = $ending_balance WHERE `id` =" . $value['seq_data_id'];
            $ar = $conn->query($q);
            $activeCellNo++;
        }
        $sheet->mergeCells('A' . $activeCellNo . ':D' . $activeCellNo);
        setValueStyle($sheet, 'A' . $activeCellNo, "Total", true, 'center');
        setValueStyle($sheet, 'E' . $activeCellNo, $total_opening_balance, true, 'right');
        setValueStyle($sheet, 'F' . $activeCellNo, $total_debit, true, 'right');
        setValueStyle($sheet, 'G' . $activeCellNo, $total_credit, true, 'right');
        setValueStyle($sheet, 'H' . $activeCellNo, $total_ending_balance, true, 'right');
    } catch (Exception $e) {
        //...
        printf("Error message while quering deposit data: %s\n", $conn->error);
    }

    $depositEndCellNo = 'H' . $activeCellNo;
    $sheet->getStyle($depositStartCellNo . ':' . $depositEndCellNo)->applyFromArray($styleArray);
    // !SECTION

    // SECTION Schedule 3
    $activeCellNo = $activeCellNo + 2;
    $depositStartCellNo = 'A' . $activeCellNo;
    $sheet->mergeCells('A' . $activeCellNo . ':H' . $activeCellNo);
    $sheet->setCellValue('A' . $activeCellNo, $month . ' - ' . $year . ' (Schedule 3)');
    $sheet->getStyle('A' . $activeCellNo)->getFont()->setBold(true);
    $sheet->getStyle('A' . $activeCellNo)->getAlignment()->setHorizontal('center');
    $activeCellNo++;
    $depositHeaders = ['SR.NO', 'ALLOCATION', '', 'DETAILS OF SUSPENCE', 'OPENING', 'DEBIT', 'CREDIT', 'TOEND'];
    $alphabets = range('A', 'H');
    foreach ($depositHeaders as $key => $value) {
        if ($alphabets[$key] == 'B') {
            $sheet->mergeCells('B' . $activeCellNo . ':C' . $activeCellNo);
            $sheet->setCellValue($alphabets[$key] . $activeCellNo, $value);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getFont()->setBold(true);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getAlignment()->setHorizontal('center');
        } else if ($alphabets[$key] != 'B' && $alphabets[$key] != 'C') {
            $sheet->setCellValue($alphabets[$key] . $activeCellNo, $value);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getFont()->setBold(true);
            $sheet->getStyle($alphabets[$key] . $activeCellNo)->getAlignment()->setHorizontal('center');
        }
    }

    try {
        $qr3 = '( SELECT id as sid, head_of_account, allocation,
        case should_only_carry_forward 
            when "0" then (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "' . $previous_month_year_digit . '" and is_final = 0) 
            when "1" then (select end_of_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = "0") 
         end as opening_balance, ';
        if ($is_final && $month == 'MAR') {
            $qr3 .= "0";
        } else if ($is_final == 0) {
            $qr3 .= "(select for_the_month_debit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $current_month_year_digit . "' and is_final = 0) ";
        }
        $qr3 .= " as debit, ";
        if ($is_final && $month == 'MAR') {
            $qr3 .= "0";
        } else if ($is_final == 0) {
            $qr3 .= "(select for_the_month_credit_amount from sequence_data where sequence_id = sid and custom_year_month = '" . $current_month_year_digit . "'  and is_final = 0) ";
        }
        $qr3 .=  " as credit,";
         
        $qr3 .= ' (select id from sequence_data where sequence_id = sid and custom_year_month = "' . $current_month_year_digit . '" and is_final = 0) as seq_data_id, true as can_be_edited FROM `sequence` 
         where sequence.should_include_in_III_part = 1 and sequence.can_be_found_in_schedule = 1 order by allocation)';
        echo "<pre>";
        echo "Part III Query: \n";
        print_r($qr3);
        echo "</pre>";
        $depData = mysqli_fetch_all($conn->query($qr3), MYSQLI_ASSOC);
        $total = [
            'I' => [
                'opening_balance' => 0,
                'debit' => 0,
                'credit' => 0,
                'ending_balance' => 0,
            ],
            'III' => [
                'opening_balance' => 0,
                'debit' => 0,
                'credit' => 0,
                'ending_balance' => 0,
            ]
        ];
        $activeCellNo++;
        $start = $activeCellNo;
        foreach ($depData as $key => $value) {

            setValueStyle($sheet, 'A' . $activeCellNo, ($key + 1), true);
            $sheet->mergeCells('B' . $activeCellNo . ':C' . $activeCellNo);

            setValueStyle($sheet, 'B' . $activeCellNo, isset($value['allocation']) && $value['allocation'] != '' ? $value['allocation'] : '-', true);
            setValueStyle($sheet, 'D' . $activeCellNo, isset($value['head_of_account']) ? $value['head_of_account'] : '-', true, 'left');

            $opening_balance = isset($value['opening_balance']) ? floatval($value['opening_balance']) : 0;
            setValueStyle($sheet, 'E' . $activeCellNo, $opening_balance, false, 'right');

            $debit = isset($value['debit']) ? floatval($value['debit']) : 0;
            setValueStyle($sheet, 'F' . $activeCellNo, $debit, false, 'right');

            $credit = isset($value['credit']) ? floatval($value['credit']) : 0;
            setValueStyle($sheet, 'G' . $activeCellNo, $credit, false, 'right');

            $ending_balance = ((floatval($opening_balance) + floatval($debit)) - floatval($credit));
            setValueStyle($sheet, 'H' . $activeCellNo, $ending_balance, false, 'right');
            // if ($value['can_be_edited']) {

                $total['III']['opening_balance'] += $opening_balance;
                $total['III']['debit'] += $debit;
                $total['III']['credit'] += $credit;
                $total['III']['ending_balance'] += $ending_balance;
            // if ($depData[$key + 1]['can_be_edited'] == false) {
            //     $activeCellNo++;
            //     $sheet->mergeCells('A' . $activeCellNo . ':D' . $activeCellNo);
            //     setValueStyle($sheet, 'A' . $activeCellNo, 'Total', false, 'center');
            //     setValueStyle($sheet, 'E' . $activeCellNo, $total['III']['opening_balance'], true, 'right');
            //     setValueStyle($sheet, 'F' . $activeCellNo, $total['III']['debit'], true, 'right');
            //     setValueStyle($sheet, 'G' . $activeCellNo, $total['III']['credit'], true, 'right');
            //     setValueStyle($sheet, 'H' . $activeCellNo, $total['III']['ending_balance'], true, 'right');
            //     $activeCellNo++;
            //     $sheet->mergeCells('A' . $activeCellNo . ':H' . $activeCellNo);
            // }
                if ($value['seq_data_id'] && $value['can_be_edited']) {
                $q = "UPDATE `sequence_data` SET `end_of_month_debit_amount` = $ending_balance WHERE `id` =" . $value['seq_data_id'];
                    $ar = $conn->query($q);
                }
            // } else {
            //     $total['I']['opening_balance'] += $opening_balance;
            //     $total['I']['debit'] += $debit;
            //     $total['I']['credit'] += $credit;
            //     $total['I']['ending_balance'] += $ending_balance;
            // }
            $activeCellNo++;
        }
        $sheet->mergeCells('A' . $activeCellNo . ':D' . $activeCellNo);
        setValueStyle($sheet, 'A' . $activeCellNo, "Total", false, 'center');
        setValueStyle($sheet, 'E' . $activeCellNo,  '=SUM(E' . $start . ':E' . ($activeCellNo - 1) . ')', false, 'right');
        setValueStyle($sheet, 'F' . $activeCellNo, '=SUM(F' . $start . ':F' . ($activeCellNo - 1) . ')', false, 'right');
        setValueStyle($sheet, 'G' . $activeCellNo, '=SUM(G' . $start . ':G' . ($activeCellNo - 1) . ')', false, 'right');
        setValueStyle($sheet, 'H' . $activeCellNo, '=SUM(H' . $start . ':H' . ($activeCellNo - 1) . ')', false, 'right');
    } catch (Exception $e) {
        //...
        printf("Error message while quering deposit data: %s\n", $conn->error);
        printf("Error message while quering deposit data: %s\n", $e);
    }

    $depositEndCellNo = 'H' . $activeCellNo;
    $sheet->getStyle($depositStartCellNo . ':' . $depositEndCellNo)->applyFromArray($styleArray);
}

$file_name = "generated-files/GB-" . $month . "-" . $year . "-" . mt_rand(1, time()) . ".xlsx";
if ($is_final) {
    $file_name = "generated-files/GB-" . $month . "-" . $year . "-(Final)-" . mt_rand(1, time()) . ".xlsx";
}
$writer->save($file_name);


function setValueStyle($sheet, $cellNo, $content, $isNumber = false, $horizontalAlign = 'center')
{
    if ($isNumber) {
        $sheet->setCellValueExplicit($cellNo, $content,  \PhpOffice\PhpSpreadsheet\Cell\DataType::TYPE_STRING);
    } else {
        $sheet->setCellValue($cellNo, $content);
    }
    $sheet->getStyle($cellNo)->getFont()->setBold(true);
    $sheet->getStyle($cellNo)->getAlignment()->setHorizontal($horizontalAlign);
}
