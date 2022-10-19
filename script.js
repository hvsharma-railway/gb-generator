// $(document).ready(function () {
//     var tblData = $('table tbody tr:nth-child(8) td table tbody tr').get().map(function (row) {
//         return $(row).find('td').get().map(function (cell) {
//             return $(cell).html();
//         });
//     });
//     let actualData = [];
//     let i = 0;
//     // let requiredSeqNo = [91800, ]
//     tblData.forEach((element, index) => {
//         if (!isNaN(element[0]) && element[0].trim() && element[2] != 0 && element[2] != '&nbsp;') {
//             actualData.push({
//                 seqNo: parseFloat(element[0], 10),
//                 forTheMonth: parseFloat(element[2], 10)
//             });
//         }
//     });
//     console.log(actualData);

// });
// function submit() {
//     var $inputs = $('#gbform :input');

//     var values = {};
//     $inputs.each(function () {
//         values[this.name] = $(this).val();
//     });

//     console.log(values);
// }

