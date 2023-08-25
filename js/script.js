var tableToObj = function (table) {
    var trs = table.rows,
        trl = trs.length,
        i = 0,
        j = 0,
        keys = [],
        obj,
        ret = [];

    for (; i < trl; i++) {
        if (i == 0) {
            for (; j < trs[i].children.length; j++) {
                keys.push(trs[i].children[j].innerHTML);
            }
        } else {
            obj = {};
            for (j = 0; j < trs[i].children.length; j++) {
                obj[keys[j]] = trs[i].children[j].innerHTML;
            }
            ret.push(obj);
        }
    }

    return ret;
};

function getMonthFromString(mon) {
    var d = Date.parse(mon + "1, 2012");
    if (!isNaN(d)) {
        return ("0" + (new Date(d).getMonth() + 1)).slice(-2);
    }
    return -1;
}

function startLoader() {
    $('#uploadRevenueReportForm').waitMe({
        effect: 'bounce',
        text: '',
        bg: 'rgba(255, 255, 255, 0.7)',
        color: '#000',
        maxSize: '',
        waitTime: -1,
        textPos: 'vertical',
        fontSize: '',
        source: '',
        onClose: function () { }
    });
}

function stopLoader() {
    $('#uploadRevenueReportForm').waitMe("hide");
    $('#uploadRevenueReportForm').trigger("reset");
}

function handleRevenueReportUpload() {
    if (
        !window.File ||
        !window.FileReader ||
        !window.FileList ||
        !window.Blob
    ) {
        alert("The File APIs are not fully supported in this browser.");
        return;
    }

    var input = document.getElementById("uploadRevenueReportFile");
    // uploadRevenueScheduleFile
    if (!input) {
        alert("Um, couldn't find the fileinput element.");
    } else if (!input.files) {
        alert(
            "This browser doesn't seem to support the `files` property of file inputs."
        );
    } else if (!input.files[0]) {
        alert("Please select a file");
    } else {
        startLoader();
        var file = input.files[0];
        var fr = new FileReader();
        let then = this;
        fr.onload = function (then) {

            // Do stuff on onload, use fr.result for contents of file
            $("#file-content").append($("<div/>").html(fr.result));
            // console.log($('#file-content table tbody tr:nth-child(8) td table tbody tr td:first-child:not(empty)'));
            // let t = tableToObj($('#file-content table tbody tr:nth-child(8) td table'))
            // console.log(t);

            // console.log($('#file-content table tbody tr:nth-child(8) td table').toArray());
            let tables = $(
                "#file-content table tbody tr:nth-child(8) td table"
            ).toArray();
            let time = $("#file-content table tbody tr:eq(4) td b").text();
            time = time.split(":");
            let yearMonth = time[1].trim();
            yearMonth = yearMonth.split(" ");
            yearMonth = yearMonth.filter(function (entry) {
                return entry.trim() != "";
            });
            if (yearMonth.length > 1) {
                yearMonth =
                    "20" + yearMonth[1] + getMonthFromString(yearMonth[0]);
            } else {
                let monthName = yearMonth[0].match(/[a-zA-Z]+/g);
                let monthDigit = yearMonth[0].match(/\d+/g);
                yearMonth = "20" + monthDigit + getMonthFromString(monthName);
            }
            console.log(yearMonth);
            let newtables = [];
            let allRows = [];
            tables.forEach((table) => {
                newtable = tableToObj(table);
                let newnewtable = [];
                newtable.forEach((t, i) => {
                    // console.log(t, i);
                    if (
                        t["SEQ NO"].trim() &&
                        t["<b>For the <br>Month</b>"] != "&nbsp;" &&
                        (t["SEQ NO"].trim() != 36200 || t["SEQ NO"].trim() != '36200')
                    ) {
                        allRows.push({
                            sequence_id: parseInt(t["SEQ NO"]),
                            for_the_month: parseFloat(t["<b>For the <br>Month</b>"]),
                            year_month: yearMonth,
                        });
                    }

                    if (
                        t["SEQ NO"] == " " &&
                        t["<b>HEAD OF ACCOUNT</b>"] == "TRANSFERS DIVISIONAL"
                    ) {
                        allRows.push({
                            sequence_id: '36200-I',
                            for_the_month: parseFloat(t["<b>For the <br>Month</b>"]),
                            year_month: yearMonth,
                        });
                    }

                    if (
                        t["SEQ NO"] == " " &&
                        t["<b>HEAD OF ACCOUNT</b>"] == "TRANSFERS RAILWAY CAPITAL "
                    ) {
                        allRows.push({
                            sequence_id: '36200-II',
                            for_the_month: parseFloat(t["<b>For the <br>Month</b>"]),
                            year_month: yearMonth,
                        });
                    }
                    // if(parseFloat(t['<b>For the <br>Month</b>']) === NaN){
                    // }
                });
                newtables.push(newtable);
            });
            console.log("from revenue report");
            console.log(allRows);
            // $('#file-content table tbody tr:nth-child(8) td table').forEach(element => {
            //   console.log(element);
            // });

            $.ajax({
                url: 'src/store-revenue-report.php',
                type: 'POST',
                data: JSON.stringify({ 'sequence_data': allRows }),
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    toastr.success(data.message, data.status);
                    window.setTimeout('location.reload()', 2000);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    toastr.error(errorThrown, textStatus);
                },
                cache: false,
                contentType: false,
                processData: false,
            });
            $('#file-content').remove();
            stopLoader();
        };
        var text = fr.readAsText(file);
        // console.log(text);
        //fr.readAsBinaryString(file); //as bit work with base64 for example upload to server
        // fr.readAsDataURL(file);
    }
}

function handleRevenueScheduleUpload() {
    if (
        !window.File ||
        !window.FileReader ||
        !window.FileList ||
        !window.Blob
    ) {
        alert("The File APIs are not fully supported in this browser.");
        return;
    }

    var input = document.getElementById("uploadRevenueScheduleFile");
    // uploadRevenueScheduleFile
    if (!input) {
        alert("Um, couldn't find the fileinput element.");
    } else if (!input.files) {
        alert(
            "This browser doesn't seem to support the `files` property of file inputs."
        );
    } else if (!input.files[0]) {
        alert("Please select a file before clicking 'Load'");
    } else {
        startLoader();
        var file = input.files[0];
        var fr = new FileReader();
        let then = this;
        fr.onload = function (then) {
            // Do stuff on onload, use fr.result for contents of file
            $("#file-content-1").append($("<div/>").html(fr.result));
            // console.log($('#file-content table tbody tr:nth-child(8) td table tbody tr td:first-child:not(empty)'));
            // let t = tableToObj($('#file-content table tbody tr:nth-child(8) td table'))
            // console.log(t);
            let finalheads = {
                amount: 0,
                counter: 1,
                text: "Final Heads (Excluding Suspense, Accident - Compensation and Pensionary Charges)"
            };
            let misAdvRevOth = {
                amount: 0,
                counter: 2,
                text: "Miscellaneous Advance Revenue Others"
            };
            let misAdvRevGST = {
                amount: 0,
                counter: 2,
                text: "Miscellaneous Advance Revenue (GST)"
            };
            let misAdvRevC19 = {
                amount: 0,
                counter: 2,
                text: "Miscellaneous Advance Revenue (COVID-19)"
            };
            let demandPayable = {
                amount: 0,
                counter: 2,
                text: "Demand payable"
            };
            let demandsRecoverable = {
                amount: 0,
                counter: 1,
                text: "Demands Recoverable"
            };
            let grossTotal = {
                amount: 0,
                counter: 1,
                text: "Gross Earnings"
            };
            let cgstItcFull = {
                amount: 0,
                counter: 1,
                text: "CGST ITC Full"
            };
            let sgstItcFull = {
                amount: 0,
                counter: 1,
                text: "SGST ITC Full"
            };
            let cgstItcMiscAdvRevenue = {
                amount: 0,
                counter: 1,
                text: "CGST ITC Misc Adv. Revenue (PARTIAL)"
            };
            let sgstItcMiscAdvRevenue = {
                amount: 0,
                counter: 1,
                text: "SGST ITC Misc Adv. Revenue (PARTIAL)"
            };
            let ugstItcMiscAdvRevenue = {
                amount: 0,
                counter: 1,
                text: "UGST ITC Misc Adv. Revenue (PARTIAL)"
            };
            let igstItcMiscAdvRevenue = {
                amount: 0,
                counter: 1,
                text: "IGST ITC Misc Adv. Revenue (PARTIAL)"
            };

            let sus19Counter = 2;
            let finalArrToBeSent = [];
            $("#file-content-1 table tr").each(function (index) {
                if ($(this).find("td:first").html() ===
                    "Total Grant No.3 to 13<br>Final Heads (Excluding <br>Suspense,Accident-<br>Compensation and Pensionary Charges)") {
                    let amt = parseFloat($("#file-content-1 table tr").eq(index + 2).find("td").eq(1).html());
                    let chargedAmount = parseFloat($("#file-content-1 table tr").eq(index + 3).find("td").eq(1).html());
                    if (finalheads.counter === 1) {
                        finalheads.amount = amt + chargedAmount;
                    }
                    console.log(finalheads.amount);
                    finalheads.counter--;
                } else if (
                    $(this).find("td:first").html() ===
                    "Miscellaneous Advance Revenue Others"
                ) {
                    let amt = parseFloat($(this).find("td").eq(2).html());
                    if (misAdvRevOth.counter === 2) {
                        misAdvRevOth.amount = amt;
                        // finalArrToBeSent.push({
                        //     allocation: '12112101',
                        //     debit: amt,
                        //     credit: 0
                        // })
                    } else if (misAdvRevOth.counter === 1) {
                        finalArrToBeSent.push({
                            allocation: '12112101',
                            debit: misAdvRevOth.amount,
                            credit: 0 // This is static 0 because misc rev other credit contains a whole lot of allocations, one of which is CUG Recovery Credit. We cannot interpret from Revenue schedule whether mis adv rev others contains the cug rec credit amount unless we have direct api access. Hence it's kept 0 as of now.
                        });
                        misAdvRevOth.amount = misAdvRevOth.amount - amt;
                    }
                    misAdvRevOth.counter--;
                } else if (
                    $(this).find("td:first").html() ===
                    "Miscellaneous Advance Revenue (GST)"
                ) {
                    let amt = parseFloat($(this).find("td").eq(2).html());
                    if (misAdvRevGST.counter === 2) {
                        misAdvRevGST.amount = amt;
                    } else if (misAdvRevGST.counter === 1) {
                        misAdvRevGST.amount = misAdvRevGST.amount - amt;
                    }
                    misAdvRevGST.counter--;
                } else if (
                    $(this).find("td:first").html() ===
                    "Miscellaneous Advance Revenue (COVID-19)"
                ) {
                    let amt = parseFloat($(this).find("td").eq(2).html());
                    if (misAdvRevC19.counter === 2) {
                        misAdvRevC19.amount = amt;
                    } else if (misAdvRevC19.counter === 1) {
                        misAdvRevC19.amount = misAdvRevC19.amount - amt;
                    }
                    misAdvRevC19.debit = misAdvRevC19.amount;
                    misAdvRevC19.credit = 0;
                    misAdvRevC19.counter--;
                } else if ($(this).find("td:first").html() === "Demand payable") {
                    let amt = parseFloat($(this).find("td").eq(2).html());
                    if (demandPayable.counter === 2) {
                        demandPayable.amount = amt;
                    } else if (demandPayable.counter === 1) {
                        demandPayable.amount = demandPayable.amount - amt;
                    }
                    demandPayable.counter--;
                }
                else if ($(this).find("td:first").contents().eq(0).text() === "DEMANDS RECOVERABLE") {
                    if (demandsRecoverable.counter == 1) {
                        let credit = parseFloat($(this).find("td").eq(1).text());
                        let debit = 0;
                        if ($("#file-content-1 table tr").eq(index + 6).find("td").eq(0).text().trim() === "DEMANDS RECOVERABLE") {
                            debit = $("#file-content-1 table tr").eq(index + 6).find("td").eq(1).text();
                        }
                        demandsRecoverable.amount = credit - debit;
                        demandsRecoverable.counter--;
                    }
                }
                else if ($(this).find("td:first").html() === "<b>TOTAL GROSS EARNINGS</b><br>&nbsp;") {
                    if (grossTotal.counter === 1) {
                        grossTotal.amount = parseFloat($(this).find("td").eq(1).text());
                    }
                    grossTotal.counter--;
                }
                else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT CLAIMS(00844501)") {
                    finalArrToBeSent.push({
                        allocation: '00844501',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                }
                else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT BOOKS [UNPAID WAGES] FIRST HALF(00844510)") {
                    finalArrToBeSent.push({
                        allocation: '00844510',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                }
                else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT ESTABLISHMENT NON GAZZ(00844507)") {
                    finalArrToBeSent.push({
                        allocation: '00844507',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT PF(00844505)") {
                    finalArrToBeSent.push({
                        allocation: '00844505',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT NPS(00844572)") {
                    finalArrToBeSent.push({
                        allocation: '00844572',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT PENSION(00844508)") {
                    finalArrToBeSent.push({
                        allocation: '00844508',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT COAL(00844506)") {
                    finalArrToBeSent.push({
                        allocation: '00844506',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "LABOUR CESS  CHARGE (00844551)") {
                    finalArrToBeSent.push({
                        allocation: '00844551',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT SECURITY(00844553)") {
                    finalArrToBeSent.push({
                        allocation: '00844553',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT EXPENDITURE(00844519)") {
                    finalArrToBeSent.push({
                        allocation: '00844519',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT ECC BANK(00844512)") {
                    finalArrToBeSent.push({
                        allocation: '00844512',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT H.S.D.OIL(00844515)") {
                    finalArrToBeSent.push({
                        allocation: '00844515',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT WORKS(00844521)") {
                    finalArrToBeSent.push({
                        allocation: '00844521',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT BOOKS EARNEST MONEY(00844533)") {
                    finalArrToBeSent.push({
                        allocation: '00844533',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT CIPS(00844539)") {
                    finalArrToBeSent.push({
                        allocation: '00844539',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT PM RELIEF FUND(00844540)") {
                    finalArrToBeSent.push({
                        allocation: '00844540',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT STORES-LIQUIDITY DAMAGE(00844583)") {
                    finalArrToBeSent.push({
                        allocation: '00844583',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT STORES-SECURITY DEPOSIT(00844584)") {
                    finalArrToBeSent.push({
                        allocation: '00844584',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT MISC TDS CGST(00844541)") {
                    finalArrToBeSent.push({
                        allocation: '00844541',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT MISC TDS SGST(00844542)") {
                    finalArrToBeSent.push({
                        allocation: '00844542',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT MISC TDS IGST(00844544)") {
                    finalArrToBeSent.push({
                        allocation: '00844544',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT EST GAZZ(D n G)(00844566)") {
                    finalArrToBeSent.push({
                        allocation: '00844566',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Deposit Misc CGST Output Tax Liablity(00844545)") {
                    finalArrToBeSent.push({
                        allocation: '00844545',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Deposit Misc SGST Output Tax Liablity(00844546)") {
                    finalArrToBeSent.push({
                        allocation: '00844546',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Deposit Misc IGST Output Tax Liablity(00844548)") {
                    finalArrToBeSent.push({
                        allocation: '00844548',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT CGST RCM TAX LIABLITY(00844595)") {
                    finalArrToBeSent.push({
                        allocation: '00844595',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT SGST RCM TAX LIABLITY(00844596)") {
                    finalArrToBeSent.push({
                        allocation: '00844596',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT CESS RCM TAX LIABLITY(00844599)") {
                    finalArrToBeSent.push({
                        allocation: '00844599',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT EST NON GAZZ(D n G)(00844567)") {
                    finalArrToBeSent.push({
                        allocation: '00844567',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "PM CARES FUND(00844569)") {
                    finalArrToBeSent.push({
                        allocation: '00844569',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "EBR-IRFC Fund Source (84)") {
                    finalArrToBeSent.push({
                        allocation: 'EBR84',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "EBR-Special Fund Source (85)") {
                    finalArrToBeSent.push({
                        allocation: 'EBR85',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "EBR-SPECIAL(00844685)") {
                    finalArrToBeSent.push({
                        allocation: '00844685',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT IRFC(00844528)") {
                    finalArrToBeSent.push({
                        allocation: '00844528',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT RAILWAY MINISTERS WELFARE AND RELIEF(00844514)") {
                    finalArrToBeSent.push({
                        allocation: '00844514',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Deposit Misc UTGST Output Tax Liablity(00844547)") {
                    finalArrToBeSent.push({
                        allocation: '00844547',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "DEPOSIT WORKS-CONT/WORKS TAX(00844531)") {
                    finalArrToBeSent.push({
                        allocation: '00844531',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue CGST-12111572") {
                    finalArrToBeSent.push({
                        allocation: '12111572',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue SGST-12111573") {
                    finalArrToBeSent.push({
                        allocation: '12111573',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue IGST-12111575") {
                    finalArrToBeSent.push({
                        allocation: '12111575',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue CGST-12111672") {
                    finalArrToBeSent.push({
                        allocation: '12111672',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue SGST-12111673") {
                    finalArrToBeSent.push({
                        allocation: '12111673',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue IGST-12111675") {
                    finalArrToBeSent.push({
                        allocation: '12111675',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                } else if ($(this).find("td").contents().eq(0).text() === "Misc Adv Revenue UGST-12111674") {
                    finalArrToBeSent.push({
                        allocation: '12111674',
                        debit: $(this).find("td").eq(1).text(),
                        credit: $(this).find("td").eq(2).text()
                    })
                }

                sus19Counter--;
            });
            finalArrToBeSent.push(finalheads);
            finalArrToBeSent.push(misAdvRevOth);
            finalArrToBeSent.push(misAdvRevGST);
            finalArrToBeSent.push(misAdvRevC19);
            finalArrToBeSent.push(demandPayable);
            finalArrToBeSent.push(demandsRecoverable);
            finalArrToBeSent.push(grossTotal);

            let path = "#file-content-1 table tbody tr:eq(5) td b";
            let time = $(path).text();
            let isSupplementary = $(path).text().includes("Supplementary");
            yearMonth = time.split(" ");
            yearMonth = yearMonth.filter(function (entry) {
                return entry.trim() != "";
            });
            let last2Digits = yearMonth[yearMonth.length - 1];
            if (isSupplementary) {
                last2Digits = yearMonth[yearMonth.length - 4];
            }
            let month = yearMonth[yearMonth.length - 2];
            if (isSupplementary) {
                month = yearMonth[yearMonth.length - 5];
            }
            console.log(month, isNaN(last2Digits));
            if (isNaN(last2Digits)) {
                split = last2Digits.split(/(\d+)/);
                split = split.filter(function (entry) {
                    return entry.trim() != "";
                });
                last2Digits = split[1];
                month = split[0];
            }
            console.log(last2Digits, month);
            if (yearMonth.length > 1) {
                yearMonth =
                    "20" + last2Digits + getMonthFromString(month);
            }
            console.log(yearMonth, finalArrToBeSent);
            $.ajax({
                url: 'src/store-revenue-schedule.php',
                type: 'POST',
                data: JSON.stringify({ 'sequence_data': finalArrToBeSent, 'year_month': yearMonth }),
                dataType: 'json',
                success: function (data) {
                    console.log(data);
                    toastr.success(data.message, data.status);
                    window.setTimeout('location.reload()', 2000);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    toastr.error(errorThrown, textStatus);
                },
                cache: false,
                contentType: false,
                processData: false,
            });
            $('#file-content-1').remove();
            stopLoader();
        };
        var text = fr.readAsText(file);
        // console.log(text);
        //fr.readAsBinaryString(file); //as bit work with base64 for example upload to server
        // fr.readAsDataURL(file);
    }
}

function generateExcel() {
    var date = new Date(),
        y = $("#year").val(),
        m = String(+getMonthFromString($("#month").val())).padStart(2, '0');
    var firstDay = new Date(y, m, 1);
    var lastDay = new Date(y, +m + 1, 0);

    var FD = new Date(firstDay);
    var LD = new Date(lastDay);
    let month = $("#month").val();
    let formValue = {
        month_full: month.includes('Final') ? 'Mar' : month,
        is_final: month.includes('Final'),
        month: m,
        start_date: FD.getDate() + '/' + (FD.getMonth()) + '/' + FD.getFullYear(),
        end_date: LD.getDate() + '/' + (LD.getMonth()) + '/' + LD.getFullYear(),
        year: y
    }
    console.log(formValue);
    $.ajax({
        url: "src/excel-generator.php",
        type: "POST",
        data: JSON.stringify(formValue),
        dataType: 'binary',
        xhrFields: {
            'responseType': 'blob'
        },
        success: function (data, status, xhr) {
            console.log(status, xhr.getResponseHeader('Content-Disposition'))
            var link = document.createElement('a');
            const contentDisposition = xhr.getResponseHeader('Content-Disposition');
            const fileNameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
            const matches = fileNameRegex.exec(contentDisposition);
            const fileName = matches[1].replace(/['"]/g, '');
            const decodedFileName = decodeURIComponent(fileName);
            link.href = URL.createObjectURL(data);
            link.download = decodedFileName;
            link.click();
        }
    });
}