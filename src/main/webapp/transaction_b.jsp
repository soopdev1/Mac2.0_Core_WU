<%@page import="rc.so.entity.BlacklistM"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.entity.Till"%>
<%@page import="rc.so.entity.Office"%>
<%@page import="rc.so.entity.Client"%>
<%@page import="rc.so.entity.Company"%>
<%@page import="rc.so.entity.Currency"%>
<%@page import="rc.so.entity.Agency"%>
<%@page import="rc.so.entity.Figures"%>
<%@page import="rc.so.entity.CustomerKind"%>
<%@page import="rc.so.util.List_new"%>
<%@page import="rc.so.util.Constant"%>
<%@page import="rc.so.util.List_ma"%>
<%@page import="rc.so.util.Engine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="rc.so.util.Etichette"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String link_value = Engine.verifyUser(request);
    if (link_value != null) {
        Utility.redirect(request, response, link_value);
    }
%>
<!DOCTYPE HTML>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->
    <head>
        <meta charset="utf-8" />
        <title>Mac2.0 - Buy Tr.</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="assets/soop/fontg/fontsgoogle1.css" rel="stylesheet" type="text/css" />

        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/bootstrap-5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!--<link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />-->
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />

        <link href="assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/bootstrap-select-1.13.14/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/select2-4.0.13/css/select2.min.css" rel="stylesheet" type="text/css" />
        
        <link href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/bootstrap-select-1.13.14/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="assets/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />

        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="assets/layouts/layout/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/layouts/layout/css/themes/darkblue.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="assets/layouts/layout/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 

        <script src="assets/soop/js/pace.js" type="text/javascript"></script>
        <link rel="stylesheet" href="assets/soop/css/pace-theme-center-circle.css" />

        <script src="assets/soop/js/controlli.js" type="text/javascript"></script>
        <script src="assets/soop/js/bignumber.js" type="text/javascript"></script>
        <script src="assets/soop/js/accounting.min.js" type="text/javascript"></script>
        <script src="assets/soop/js/core-min.js" type="text/javascript"></script>
        <script src="assets/soop/js/md5-min.js" type="text/javascript"></script>
        <script src="assets/soop/js/md5.js" type="text/javascript"></script>
        <script src="assets/soop/js/moment.js" type="text/javascript"></script>
        <script src="assets/soop/js/cf.js" type="text/javascript"></script>
        <script src="assets/soop/js/validate.min.js" type="text/javascript"></script>

        
        <script type="text/javascript" src="assets/soop/js/jquery.fancybox.js?v=2.1.5"></script>
        <link rel="stylesheet" type="text/css" href="assets/soop/css/jquery.fancybox.css?v=2.1.5" media="screen" />
        <script type="text/javascript" src="assets/soop/js/fancy.js"></script>

        <%
            boolean iscentral = Engine.isCentral();
            //iscentral = false;
            String esito = (String) session.getAttribute("esito_b");
            if (esito == null) {
                esito = request.getParameter("esito");
                if (esito == null || esito.equals("null")) {
                    esito = "none";
                }
            } else {
                esito = StringUtils.split(esito, "&")[0];
            }
            session.setAttribute("esito_b", null);

            double so_1 = Engine.get_soglia_CZ();

            String pswx = session.getAttribute("us_pwd").toString();
            String nation = Constant.nation;
            String decimal = Constant.decimal;
            String thousand = Constant.thousand;

            List_new ln = new List_new("B", session);

            String cod = Utility.generaIdMAC(ln.getFil());
            String Token = Utility.generaId(50);
            Office head = ln.getHeadhoffice();
            String operator = head.getChangetype();

            //String oper_mol = head.getChangeOperator();
            String rst = head.getDecimalround();

            boolean showagency = ln.isAgencyenabled();
            String local_cur = ln.getLocalcur()[0];

            ArrayList<String[]> array_till = ln.getArray_till();
            ArrayList<Till> array_till_open = ln.getArray_till_open();
            ArrayList<Agency> array_agency = ln.getArray_agency();
            ArrayList<CustomerKind> array_custkind = ln.getArray_custkind();
            ArrayList<String[]> array_country = ln.getArray_country();
            ArrayList<String[]> array_country_1 = ln.getCountryFlag("1");
            ArrayList<String[]> array_country_2 = ln.getCountryFlag("2");
            ArrayList<String[]> array_country_3 = ln.getCountryFlag("3");
            ArrayList<Figures> array_figbuy = ln.getArray_figbuy();
            ArrayList<String[]> array_identificationCard = ln.getArray_identificationCard();
            ArrayList<Currency> array_currency = ln.getArray_currency();
            ArrayList<String[]> array_kind_currency_enabled = ln.getArray_kind_currency_enabled();
            ArrayList<String[]> array_rate_currency = ln.getArray_rate_currency();
            ArrayList<String[]> array_credit_card = ln.getArray_credit_card();
            ArrayList<String[]> array_undermincommjustify = ln.getArray_undermincommjustify();
            ArrayList<String[]> array_unlockrate = Engine.unlockratejustify();
            ArrayList<Company> array_listCompany = ln.getArray_listCompany();
            ArrayList<String[]> array_kindcommissionefissa = ln.getArray_kindcommissionefissa();
            ArrayList<String[]> array_fixcommrange = ln.getArray_fixcommrange();
            ArrayList<String[]> array_district = ln.getArray_district();
            String linkfisso_scanner = Utility.createServerReturnScannerLink(cod);
        %>
        <script type="text/javascript">
            function RemoveAccents(str) {
                var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
                var accentsOut = "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
                str = str.split('');
                var strLen = str.length;
                var i, x;
                for (i = 0; i < strLen; i++) {
                    if ((x = accents.indexOf(str[i])) !== -1) {
                        str[i] = accentsOut[x] + "'";
                    }
                }
                return str.join('');
            }

            function modificaOAMSurname(field, event) {
                field.value = RemoveAccents(field.value.toUpperCase());
                fieldNameSurnameNEW(field.id);
            }
            function modificaOAM_soloap(field, event) {
                field.value = RemoveAccents(field.value.toUpperCase());
                field.value = field.value.replace(/[`~!@£§°#$%^&*()_|+\-=?;:",.<>\{\}\[\]\\\/]/gi, '');
            }

            function modificaOAM_Add(field, event) {
                field.value = RemoveAccents(field.value.toUpperCase());
                field.value = field.value.replace(/[`~!@#$§°%^£&*()_|+\=?;:",.<>\{\}\[\]]/gi, '');
            }

            function modificaLOY(field, event) {
                field.value = RemoveAccents(field.value.toUpperCase().trim());
                field.value = field.value.replace(/[`~!@#$§°%^£&*()_|+\=?;:",.<>\{\}\[\]]/gi, '');
            }

            function modificaOAM(field, event) {
                field.value = RemoveAccents(field.value.toUpperCase());
                var specialChars = "~`!#$%^&*+=-[]();,/{}|\":<>§°?£,.àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜ_Ý°èéòàù§*ç@|!£$%&/()=?^€ì'";
                for (var i = 0; i < specialChars.length; i++) {
                    field.value = field.value.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
                }
                field.value = field.value.replace(/\\/g, "");
                //fieldNOSPecial(field.id);
            }

            function fieldNameSurnameNEW(fieldid) {
                var stringToReplace = document.getElementById(fieldid).value;
                var specialChars = "~`!#$%^&*+=-[]();,/{}|\":<>?£,.àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜ_Ý°èéòàù§*ç@|!£$%&/()=?^€ì";
                for (var i = 0; i < specialChars.length; i++) {
                    stringToReplace = stringToReplace.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
                }
                stringToReplace = stringToReplace.replace(new RegExp("[0-9]", "g"), "");
                document.getElementById(fieldid).value = stringToReplace;
            }

            var separatordecimal = "<%=decimal%>";
            var separatorthousand = "<%=thousand%>";

            function checkesito() {
                var es1 = '<%=esito%>';
                if (es1 !== "none") {
                    var ermsg = "";
                    if (es1 === "kobl") {
                        ermsg = "<span class='font-red'>Attention! </span>Not executable transaction. This name is present in the international blacklist";
                    } else if (es1 === "koblm") {
                        var cod1 = "<%=request.getParameter("codbl")%>";
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "Operazioni_test?type=verificaBLM&cod=" + cod1,
                            success: function (data) {
                                if (data === "RAFOK") {

                                } else {
                                    ermsg = data;
                                }
                            }
                        });
                    } else if (es1 === "koins2") {
                        ermsg = "You must select at least one row.";
                    } else if (es1 === "koquant") {
                        ermsg = "Pay out exceeds the amount of local currency in cash.";
                    } else if (es1 === "kofidelcodemax") {
                        ermsg = "Quantity exceeds the amount of fidelity code buy back.";
                    } else if (es1 === "kofidelcode") {
                        ermsg = "Fidelity code not found.";
                    } else if (es1 === "komaxsett") {
                        ermsg = "The max weekly threshold has been exceeded.";
                    } else if (es1 === "koins" || es1 === "koins1") {
                        //ermsg = "Character not allowed: à è é ì ò ù. Please verify";
                        ermsg = "Error in customer data. Please verify.";
                    } else if (es1 === "kofatt") {
                        ermsg = "Unable to generate invoice.Try again.";
                    } else if (es1 === "co1") {
                        ermsg = "Error. This Unlock Code is not found or this code is already used.";
                    }

                    document.getElementById('errorlargetext').innerHTML = ermsg;
                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                    document.getElementById('errorlarge').style.display = "block";

                }
            }

            function loadtill() {
            <%for (int j = 0; j < array_till_open.size(); j++) {
                    if (!array_till_open.get(j).isSafe()) {%>
                var o = $("<option/>", {value: "<%=array_till_open.get(j).getCod()%>", text: "<%=Utility.formatAL(array_till_open.get(j).getCod(), array_till, 1)%>"});
                $('#till').append(o);
            <%}
                }%>
                $('#till').val($('#till option:first-child').val()).trigger('change');
            }

            //  show row 
            function showRow() {
                var ind = document.getElementById("index_t1").value;
                ind = parseInt(ind) + 1;
                document.getElementById("index_t1").value = ind;
                document.getElementById("trfig" + ind).style.display = "";
                if (document.getElementById("Btrfig" + ind) !== null) {
                    document.getElementById("Atrfig" + ind).style.display = "";
                    document.getElementById("Btrfig" + ind).style.display = "";
                    document.getElementById("Ctrfig" + ind).style.display = "";
                    document.getElementById("Dtrfig" + ind).style.display = "";

                }
                loadkind(ind);
                kindfixcomm(ind);
                changeKind(ind);
                changefigs(ind);
                changequantity(ind);
                changeFixcomm_kind(ind);
                setvalue(ind);
            }

            //  reset row
            function resetRow(index) {
                var quant = "quantity" + index;
                var kind = "kind" + index;
                var figures = "figs" + index;
                var rate = "rate" + index;
                var fieldrate = "fieldrate" + index;
                var fx_com = "fxcomm" + index;
                var kindfixcomm1 = "kindfixcomm" + index;
                var comm = "comperc" + index;
                var totperc = "totperc" + index;
                var totcomm = "totcomm" + index;
                var pos = "posvalue" + index;
                var posnum = "posnum" + index;
                var net = "net" + index;
                var total = "total" + index;
                var justify = "lowcommjus" + index;

                var fidcode = "fidcode" + index;

                var spread = "spread" + index;
                document.getElementById(spread).value = '';
                document.getElementById(spread).disabled = true;

                $('#' + kind).html('').select2({data: [{id: '', text: ''}]});
                document.getElementById(kind).disabled = true;
                $('#' + figures).html('').select2({data: [{id: '', text: ''}]});
                document.getElementById(figures).disabled = true;
                $('#' + rate).html('').select2({data: [{id: '', text: ''}]});
                document.getElementById(rate).disabled = true;
                //$('#' + kindfixcomm1).html('').select2({data: [{id: '', text: ''}]});
                document.getElementById(kindfixcomm1).disabled = true;
                document.getElementById(justify).disabled = true;
                document.getElementById(pos).disabled = true;
                document.getElementById(posnum).value = "";
                document.getElementById(posnum).disabled = true;
                document.getElementById(justify).disabled = true;
                document.getElementById(quant).value = '';
                document.getElementById(quant).disabled = true;
                document.getElementById(fieldrate).value = '';
                document.getElementById(fieldrate).disabled = true;
                document.getElementById(comm).value = '';
                document.getElementById(comm).disabled = true;
                document.getElementById(totperc).value = '';
                document.getElementById(totperc).disabled = true;
                document.getElementById(fx_com).value = '';
                document.getElementById(fx_com).disabled = true;
                document.getElementById(totcomm).value = '';
                document.getElementById(totcomm).disabled = true;
                document.getElementById(net).value = '';
                document.getElementById(net).disabled = true;
                document.getElementById(total).value = '';
                document.getElementById(total).disabled = true;

                document.getElementById(fidcode).value = '';
                document.getElementById(fidcode).disabled = true;

                disable_sel2('bb' + index, 'form1');
                disable_sel2('sb' + index, 'form1');


                document.getElementById("delrow" + index).style.display = "none";
                document.getElementById("enarow" + index).style.display = "";
                document.getElementById("trfig" + index).style.background = "#eef1f5";
                setvalue(index);
            }

            function enableRow(index) {
                var quant = "quantity" + index;
                var kind = "kind" + index;
                var figures = "figs" + index;
                var rate = "rate" + index;
                var fieldrate = "fieldrate" + index;
                var fx_com = "fxcomm" + index;
                var kindfixcomm1 = "kindfixcomm" + index;
                var comm = "comperc" + index;
                var totperc = "totperc" + index;
                var totcomm = "totcomm" + index;
                var pos = "posvalue" + index;
                var net = "net" + index;
                var total = "total" + index;
                var justify = "lowcommjus" + index;
                var fidcode = "fidcode" + index;

                var spread = "spread" + index;
                document.getElementById(spread).value = '0' + separatordecimal + '00';

                document.getElementById(kind).disabled = false;
                $('#' + kind).empty();
                document.getElementById(figures).disabled = false;
                document.getElementById(rate).disabled = false;
                document.getElementById(kindfixcomm1).disabled = false;
                //$('#' + kindfixcomm1).empty();
                document.getElementById(pos).disabled = true;
                document.getElementById(justify).disabled = true;
                document.getElementById(quant).disabled = false;
                document.getElementById(quant).value = '1' + separatordecimal + '00';
                document.getElementById(fieldrate).disabled = false;
                document.getElementById(fieldrate).value = '0' + separatordecimal + '00';
                document.getElementById(comm).disabled = false;
                document.getElementById(comm).value = '0' + separatordecimal + '00';
                document.getElementById(totperc).disabled = false;
                document.getElementById(totperc).value = '0' + separatordecimal + '00';
                document.getElementById(fx_com).disabled = false;


                document.getElementById(fx_com).value = '0' + separatordecimal + '00';
                document.getElementById(totcomm).disabled = false;
                document.getElementById(totcomm).value = '0' + separatordecimal + '00';
                document.getElementById(net).disabled = false;
                document.getElementById(net).value = '0' + separatordecimal + '00';
                document.getElementById(total).disabled = false;
                document.getElementById(total).value = '0' + separatordecimal + '00';

                enable_sel2('bb' + index, 'form1');
                disable_sel2('sb' + index, 'form1');
                document.getElementById(fidcode).value = '';
                document.getElementById(fidcode).disabled = true;

                document.getElementById("delrow" + index).style.display = "";
                document.getElementById("enarow" + index).style.display = "none";
                document.getElementById("trfig" + index).style.background = "#ffffff";





                loadkind(index);
                kindfixcomm(index);
                changeKind(index);
                changefigs(index);
                changequantity(index);
                changeFixcomm_kind(index);
                setvalue(index);

            }

            function zeroFill(number, width) {
                width -= number.toString().length;
                if (width > 0) {
                    return new Array(width + (/\./.test(number) ? 2 : 1)).join('0') + number;
                }
                return number + "";
            }

            function check_fidelity_cod(index) {
                var field = document.getElementById('fidcode' + index);


                if (!field.disabled) {
                    var val = field.value.trim();
                    if (val !== "") {



                        if (val.length !== 18) {
                            var b1 = val.substring(0, 3);
                            var b2 = val.substring(3);
                            var b3 = zeroFill(b2, 15);
                            document.getElementById('fidcode' + index).value = b1 + b3;
                            val = b1 + b3;
                        }



                        $.ajax({
                            type: "POST",
                            url: "Query?type=queryfidelitycode&q=" + val,
                            success: function (data) {
                                if (data !== "") {
                                    var arrayJson = JSON.parse(data);
                                    if (arrayJson.length > 0) {
                                        if (arrayJson[26] !== document.getElementById('customerKind').value) {
                                            $('#customerKind').val(arrayJson[26]).trigger('change');
                                            changecustomerKind("true");
                                        }
                                        if (arrayJson[0] === "" || arrayJson[1] === "") {
                                            document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                            document.getElementById('infolarge').style.display = "block";
                                            document.getElementById('infolargetext').innerHTML = 'The customer has been recognized.';
                                        } else {
                                            document.getElementById('heavy_surname').value = arrayJson[0];
                                            document.getElementById('heavy_name').value = arrayJson[1];
                                            $('#heavy_country').val(arrayJson[2]).trigger('change');
                                            if (arrayJson[18] !== "-") {
                                                var o = $("<option/>", {value: arrayJson[3], text: arrayJson[23]});
                                                $('#heavy_city').append(o);
                                                $('#heavy_city').val($('#heavy_city option:first-child').val()).trigger('change');
                                                document.getElementById('heavy_city_dis').value = arrayJson[3];
                                            }


                                            if (arrayJson[19] !== "-") {
                                                var o = $("<option/>", {value: arrayJson[6], text: arrayJson[24]});
                                                $('#heavy_district').append(o);
                                                $('#heavy_district').val($('#heavy_district option:first-child').val()).trigger('change');
                                                document.getElementById('heavy_district_dis').value = arrayJson[24];



                                            }

                                            var o = $("<option/>", {value: arrayJson[7], text: document.getElementById('DE_' + arrayJson[7]).value});
                                            $('#heavy_identcard').append(o);
                                            $('#heavy_identcard').val(arrayJson[7]).trigger('change');
                                            enable_sel2('heavy_identcard', 'form1');
                                            $('#heavy_pepI').val(arrayJson[18]).trigger('change');
                                            enable_sel2('heavy_pepI', 'form1');

                                            $("#heavy_issuedateidentcard").removeAttr('readonly');
                                            document.getElementById('heavy_numberidentcard').value = arrayJson[8];

                                            $('#heavy_issuedateidentcard').datepicker().datepicker('setDate', arrayJson[9]);
                                            $('#heavy_exdateidentcard').datepicker().datepicker('setDate', arrayJson[10]);
                                            document.getElementById('heavy_issuedbyidentcard').value = arrayJson[11];
                                            document.getElementById('heavy_issuedplaceidentcard').value = arrayJson[12];
                                            document.getElementById('heavy_email').value = arrayJson[13];
                                            document.getElementById('heavy_phonenu').value = arrayJson[14];

                                            document.getElementById('heavy_address').value = arrayJson[4];
                                            document.getElementById('heavy_zipcode').value = arrayJson[5];


                                            document.getElementById('oldclient').value = arrayJson[15];
                                            document.getElementById('heavy_codfisc').value = arrayJson[16];


                                            $('#heavy_sex').val(arrayJson[17]).change();
                                            enable_sel2('heavy_sex', 'form1');

                                            document.getElementById('heavy_pob_city').value = arrayJson[19];
                                            //document.getElementById('heavy_pob_city').readOnly = true;
                                            $('#heavy_pob_country').val(arrayJson[21]).trigger('change');
                                            enable_sel2('heavy_pob_country', 'form1');


                                            if (arrayJson[20] !== "-") {

                                                if (arrayJson[20] === "---") {
                                                    $('#heavy_pob_district').val("EE").change();
                                                } else {
                                                    $('#heavy_pob_district').val(arrayJson[20]).change();
                                                }


                                                disable_sel2('heavy_pob_district', 'form1');
                                                document.getElementById('heavy_pob_district_STR').value = arrayJson[20];
                                                document.getElementById('heavy_pob_district_STR').readOnly = true;
                                            }


                                            document.getElementById('heavy_pob_date').value = arrayJson[22];
                                            //document.getElementById('heavy_pob_date').readOnly = true;


                                            if (document.getElementById("showanag").style.display === "") {
                                                //unlockheavy();
                                                document.getElementById('dataverified').style.display = '';
                                                document.getElementById('infolargetext').innerHTML = 'The customer has been recognized. Please confirm the data.';
                                            } else {
                                                document.getElementById('infolargetext').innerHTML = 'The customer has been recognized.';
                                            }

                                            document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                            document.getElementById('infolarge').style.display = "block";
                                        }








                                        //setto il notes come unico
                                        $('#kind' + index).val($('#kind' + index + ' option:first-child').val()).trigger('change');
                                        disable_sel2('kind' + index, 'form1');
                                        disable_sel2('kindfixcomm' + index, 'form1');

                                        $('#figs' + index).select2({
                                            dropdownAutoWidth: true
                                        });
                                        $('#figs' + index).empty().trigger('change');
                                        var def = $("<option/>", {value: "---", text: "None"});
                                        $('#figs' + index).append(def);


                                        document.getElementById("fxcomm" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).readOnly = true;
                                        document.getElementById("net" + index).readOnly = true;
                                        document.getElementById("fidcode" + index).readOnly = true;
                                        disable_sel2('kindfixcomm' + index, 'form1');
                                        disable_sel2('bb' + index, 'form1');

                                        if (arrayJson[27] !== "") {
                                            $('#heavy_cz_country').val(arrayJson[27]).trigger('change');
                                        }
                                        if (arrayJson[28] !== "") {
                                            $('#heavy_cz_issuingcountry').val(arrayJson[28]).trigger('change');
                                        }
                                        if (arrayJson[29] !== "") {
                                            $('#heavy_sanctions').val(arrayJson[29]).trigger('change');
                                        }
                                        if (arrayJson[30] !== "") {
                                            $('#heavy_pep').val(arrayJson[30]).trigger('change');
                                        }
                                        if (arrayJson[31] !== "") {
                                            document.getElementById('heavy_transactionre').value = arrayJson[31];
                                        }
                                        if (arrayJson[32] !== "") {
                                            document.getElementById('heavy_moneysource').value = arrayJson[32];
                                        }
                                        if (arrayJson[33] !== "") {
                                            document.getElementById('heavy_occupation').value = arrayJson[33];
                                        }

                                        if (arrayJson[34] !== "") {
                                            document.getElementById('pep_position').value = arrayJson[34];
                                        }

                                        if (arrayJson[35] !== "") {
                                            $('#pep_country').val(arrayJson[35]).trigger('change');
                                        }

                                        var startrate = 36;

                                        for (var u = 0; u < (parseIntRaf(arrayJson[startrate]) * 4); u = u + 4) {

                                            var o = $("<option/>", {value: arrayJson[startrate + u + 1], text: arrayJson[startrate + u + 1] + " - " + arrayJson[startrate + u + 2]});
                                            $('#figs' + index).append(o);



                                            if (document.getElementById('bb_ch_val_' + arrayJson[startrate + u + 1]) === null) {
                                                $('#form1').append('<input type="hidden" id="bb_ch_val_' + arrayJson[startrate + u + 1] + '" value="' + arrayJson[startrate + u + 1] + '" />');
                                            } else {
                                                document.getElementById('bb_ch_val_' + arrayJson[startrate + u + 1]).value = arrayJson[startrate + u + 1];
                                            }
                                            if (document.getElementById('bb_ch_qua_' + arrayJson[startrate + u + 1]) === null) {
                                                $('#form1').append('<input type="hidden" id="bb_ch_qua_' + arrayJson[startrate + u + 1] + '" value="' + arrayJson[startrate + u + 3] + '" />');
                                            } else {
                                                document.getElementById('bb_ch_qua_' + arrayJson[startrate + u + 1]).value = arrayJson[startrate + u + 3];
                                            }
                                            if (document.getElementById('bb_ch_rat_' + arrayJson[startrate + u + 1]) === null) {
                                                $('#form1').append('<input type="hidden" id="bb_ch_rat_' + arrayJson[startrate + u + 1] + '" value="' + arrayJson[startrate + u + 4] + '" />');
                                            } else {
                                                document.getElementById('bb_ch_rat_' + arrayJson[startrate + u + 1]).value = arrayJson[startrate + u + 4];
                                            }
                                        }

                                        $('#figs' + index).removeAttr("onchange");
                                        $("#figs" + index).change(function () {


                                            var id_fidelity = document.getElementById('fidcode' + index).value.trim();
                                            var valutascelta = document.getElementById('figs' + index).value;

                                            var er1 = false;
                                            for (var ini = 1; ini < 6; ini++) {
                                                if (ini.toString() !== index) {
                                                    var fidcode = document.getElementById('fidcode' + ini).value.trim();
                                                    var valutaaltrariga = document.getElementById('figs' + ini).value.trim();
                                                    if (id_fidelity === fidcode) {
                                                        if (valutaaltrariga === valutascelta) {
                                                            er1 = true;
                                                            break;
                                                        }
                                                    }
                                                }
                                            }

                                            if (er1) {

                                                $('#figs' + index).val($('#figs' + index + ' option:first-child').val()).trigger('change');

                                                document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                document.getElementById('errorlarge').style.display = "block";
                                                document.getElementById('errorlargetext').innerHTML = "This currency can not be selected because it is used in another line of the same BuyBack transaction.";

                                            } else {
                                                $('#rate' + index).select2({
                                                    dropdownAutoWidth: true
                                                });
                                                $('#rate' + index).removeAttr("onchange");
                                                $('#rate' + index).empty().trigger('change');

                                                if (document.getElementById('bb_ch_rat_' + valutascelta) !== null) {

                                                    var valuerate = document.getElementById('bb_ch_rat_' + valutascelta).value;
                                                    var o = $("<option/>", {value: valuerate, text: accounting.formatNumber(parseFloatRaf(valuerate.toString(), separatorthousand, separatordecimal, 8), 8, separatorthousand, separatordecimal)});
                                                    $('#rate' + index).append(o);
                                                    $('#rate' + index).val($('#rate' + index + ' option:first-child').val()).trigger('change');
                                                    disable_sel2('rate' + index, 'form1');

                                                }
                                            }

                                        });


                                        $('#quantity' + index).removeAttr("onchange");
                                        $("#quantity" + index).change(function () {
                                            var valutascelta = document.getElementById('figs' + index).value;
                                            if (document.getElementById('bb_ch_qua_' + valutascelta) !== null) {
                                                var e = formatValueDecimalMax(document.getElementById('quantity' + index), document.getElementById('bb_ch_qua_' + valutascelta).value, separatorthousand, separatordecimal);

                                                if (e === "1") {
                                                    document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                                    document.getElementById('infolarge').style.display = "block";
                                                    document.getElementById('infolargetext').innerHTML = 'The quantity indicated exceeds that of the original transaction. The maximum value will be set.';
                                                }

                                                var total = controv(
                                                        parseFloatRaf(document.getElementById('quantity' + index).value, separatorthousand, separatordecimal),
                                                        parseFloatRaf(document.getElementById('bb_ch_rat_' + valutascelta).value, separatorthousand, separatordecimal, 8)
                                                        );

                                                var total_VISUAL = new BigNumber(total.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                if (checkValueCorrect(total_VISUAL)) {
                                                    document.getElementById("total" + index).value = accounting.formatNumber(total_VISUAL, 2, separatorthousand, separatordecimal);
                                                } else {
                                                    document.getElementById("total" + index).value = '0' + separatordecimal + '00';
                                                }


                                                //
                                                var tot_comm = 0.00;
                                                var tot_comm_VISUAL = new BigNumber(tot_comm.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                if (checkValueCorrect(tot_comm_VISUAL)) {
                                                    document.getElementById("totcomm" + index).value = accounting.formatNumber(tot_comm_VISUAL, 2, separatorthousand, separatordecimal);
                                                } else {
                                                    document.getElementById("totcomm" + index).value = '0' + separatordecimal + '00';
                                                }

                                                var net = total;
                                                document.getElementById("roundvalue" + index).value = "0.00";
                                                var nation = '<%=nation%>';

                                                var r_st = '<%=rst%>';

                                                if (nation === "IT") {
                                                    var out1 = round_and_split_ita(new BigNumber(net.toString()).round(2, BigNumber.ROUND_).toFixed(2), r_st);
                                                    net = new BigNumber(parseFloatRaf(out1[0], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                    var round_t = new BigNumber(parseFloatRaf(out1[1], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                    document.getElementById("roundvalue" + index).value = round_t;
                                                }
                                                if (nation === "CZ") {
                                                    var payout_t = new BigNumber(net.toString()).round().toFixed(2);
                                                    var round_t = new BigNumber((parseFloatRaf(payout_t, separatorthousand, separatordecimal) - net).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                    net = accounting.formatNumber(payout_t, 2, separatorthousand, separatordecimal);
                                                    document.getElementById("roundvalue" + index).value = round_t;
                                                }
                                                if (nation === "GB") {
                                                    var out1 = round_and_split_UK(new BigNumber(net.toString()).round(2, BigNumber.ROUND_).toFixed(2), r_st);
                                                    net = new BigNumber(parseFloatRaf(out1[0], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                    var round_t = new BigNumber(parseFloatRaf(out1[1], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                                    document.getElementById("roundvalue" + index).value = round_t;
                                                }

                                                var net_VISUAL = new BigNumber(net.toString()).round(2, BigNumber.ROUND_CEIL);
                                                if (checkValueCorrect(net_VISUAL)) {
                                                    document.getElementById("net" + index).value = accounting.formatNumber(net_VISUAL, 2, separatorthousand, separatordecimal);
                                                } else {
                                                    document.getElementById("net" + index).value = '0' + separatordecimal + '00';
                                                }
                                                setvalue(index);
                                            }
                                        });


                                        changequantity(index);


                                    } else {
                                        document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                        document.getElementById('infolarge').style.display = "block";
                                        document.getElementById('infolargetext').innerHTML = 'This Fidelity code is not found.';
                                    }
                                } else {
                                    document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                    document.getElementById('infolarge').style.display = "block";
                                    document.getElementById('infolargetext').innerHTML = 'This Fidelity code is not found.';
                                }
                            }
                        });
                    }
                }
            }



            function change_rate2021(index) {
                f_comperc(index);
                changeFixcomm_kind(index);
            }



            function verificaSblocco_new(fieldselect) {



                if (fieldselect.value === '') {
                    return false;
                }


                var mod = false;

                if ('<%=Constant.is_CZ%>' === 'true') {
                    var kind = document.getElementById('kind1');
                    if (kind !== null) {
                        if (kind.value !== '04') {
                            if (document.getElementById('figs1') !== null) {
                                var valuecurrency = document.getElementById('figs1').value;
                                if (valuecurrency !== null && valuecurrency !== "---") {
                                    if (document.getElementById("fieldrate1") !== null) {
                                        document.getElementById("fieldrate1").style.display = "";
                                        var fieldratedest = "99" + separatorthousand + "999" + separatordecimal + "9999";
                                        $.ajax({
                                            type: "POST",
                                            async: false,
                                            url: "Query?type=getbcevalue&q=" + valuecurrency,
                                            success: function (data) {
                                                if (data !== null && data !== "") {
                                                    fieldratedest = data;
                                                }
                                            }
                                        });
                                        document.getElementById("fieldrate1").value = fieldratedest;
                                        $("#fieldrate1").off("change");
                                        $("#fieldrate1").change(function () {
                                            var fieldratedest = "99" + separatorthousand + "999" + separatordecimal + "9999";
                                            $.ajax({
                                                type: "POST",
                                                async: false,
                                                url: "Query?type=getbcevalue&q=" + document.getElementById('figs1').value,
                                                success: function (data) {
                                                    if (data !== null && data !== "") {
                                                        fieldratedest = data;
                                                    }
                                                }
                                            });
                                            formatValueDecimalMaxlengthR(this,
                                                    parseFloatRaf(fieldratedest.toString(), separatorthousand, separatordecimal),
                                                    separatorthousand, separatordecimal, 8);
                                            changequantity("1");
                                        });
                                        mod = true;
                                    }
                                    if (document.getElementById("divrate1") !== null) {
                                        document.getElementById("divrate1").style.display = "none";
                                        mod = true;
                                    }
                                    setvalue("1");
                                }
                            }
                        }
                    }
                } else {
                    for (var i = 1; i < 6; i++) {
                        if (document.getElementById("figs" + i) !== null) {
                            var kind = document.getElementById('kind' + i);
                            var valuecurrency = document.getElementById('figs' + i).value;
                            if (kind.value === '01' && valuecurrency !== "---") {
                                if (document.getElementById("fieldrate" + i) !== null) {
                                    document.getElementById("fieldrate" + i).style.display = "";
                                    var fieldratedest = "99" + separatorthousand + "999" + separatordecimal + "9999";
                                    $.ajax({
                                        type: "POST",
                                        async: false,
                                        url: "Query?type=getbcevalue&q=" + valuecurrency,
                                        success: function (data) {
                                            if (data !== null && data !== "") {
                                                fieldratedest = data;
                                            }
                                        }
                                    });
                                    $("#fieldrate" + i).val(fieldratedest);
                                    $("#fieldrate" + i).off("change");
                                    $("#fieldrate" + i).change(function () {
                                        var fieldratedest = "99" + separatorthousand + "999" + separatordecimal + "9999";
                                        $.ajax({
                                            type: "POST",
                                            async: false,
                                            url: "Query?type=getbcevalue&q=" + document.getElementById('figs' + this.id.replace('fieldrate', '')).value,
                                            success: function (data) {
                                                console.log("result change data -> " + data);
                                                if (data !== null && data !== "") {
                                                    fieldratedest = data;
                                                }
                                            }
                                        });
                                        formatValueDecimalMinlengthR(this,
                                                parseFloatRaf(fieldratedest.toString(), separatorthousand, separatordecimal),
                                                separatorthousand, separatordecimal, 8);
                                        changequantity(this.id.replace('fieldrate', ''));
                                    });
                                    mod = true;

                                }
                                if (document.getElementById("divrate" + i) !== null) {
                                    document.getElementById("divrate" + i).style.display = "none";
                                    mod = true;
                                }

                                setvalue(i);
                            }
                        }
                    }
                }
                if (mod) {
                    document.getElementById('unlockCode_final').value = 'UNLOCK';
                    document.getElementById('typerate').value = 'UNLOCK';
                    document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                    document.getElementById('infolarge').style.display = "block";
                    document.getElementById('infolargetext').innerHTML = "The rate has been successfully unlocked.";
                } else {
                    document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                    document.getElementById('infolarge').style.display = "block";
                    document.getElementById('infolargetext').innerHTML = "This function is not available in case of Cash Advance.";
                    $('#' + fieldselect.id).val('').change();
                    return false;
                }
            }

            function changetill() {
                var v1 = document.getElementById('till').value;
            <%for (int j = 0; j < array_till_open.size(); j++) {%>
                if (v1 === "<%=array_till_open.get(j).getCod()%>") {
                    document.getElementById('idopentill').value = padDigits('<%=array_till_open.get(j).getCod_opcl()%>', 15);
                    document.getElementById('idopentillv').value = '<%=array_till_open.get(j).getId_opcl()%>';
                }
            <%}%>
//                document.getElementById('idopentill').value = getRandom(5);
            }

            function getRandom(length) {
                return Math.floor(Math.pow(10, length - 1) + Math.random() * 9 * Math.pow(10, length - 1));
            }

            function verificanomecogn() {
                ricercaclientestraniero(true);

                var er = false;
                var ermsg = "";
                var cf = document.getElementById("heavy_codfisc").value.trim().toUpperCase();
                if (cf === "") {
                    return false;
                }
                var surname = document.getElementById("heavy_surname").value.trim().toUpperCase();
                var name = document.getElementById("heavy_name").value.trim().toUpperCase();
                var checksurname = getStringSurname(surname);
                var checkname = getStringName(name);
                if (checkCF(cf)) {
                    if (checksurname !== 'XXX') {
                        if (cf.substring(0, 3) !== checksurname) {
                            er = true;
                            ermsg = ermsg + "Surname does not conform<p class='ab'></p>";
                        }
                    }
                    if (checkname !== 'XXX') {
                        if (cf.substring(3, 6) !== checkname) {
                            er = true;
                            ermsg = ermsg + "Name does not conform<p class='ab'></p>";
                        }
                    }
                } else {
                    er = true;
                    ermsg = ermsg + "Tax Code Error<p class='ab'></p>";
                }

                if (er) {
                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                    document.getElementById('errorlarge').style.display = "block";
                    document.getElementById('errorlargetext').innerHTML = ermsg;
                }
            }

            function checkcodfisc() {
                var er = false;
                var ermsg = "";
                var cf = document.getElementById("heavy_codfisc").value.trim().toUpperCase();
                if (cf === "") {
                    return false;
                }
                document.getElementById("heavy_codfisc").value = cf;
                var surname = document.getElementById("heavy_surname").value.trim().toUpperCase();
                var name = document.getElementById("heavy_name").value.trim().toUpperCase();
                var checksurname = getStringSurname(surname);
                var checkname = getStringName(name);
                if (checkCF(cf)) {
                    if (checksurname !== 'XXX') {
                        if (cf.substring(0, 3) !== checksurname) {
                            er = true;
                            ermsg = ermsg + "Surname does not conform<p class='ab'></p>";
                        }
                    }
                    if (checkname !== 'XXX') {
                        if (cf.substring(3, 6) !== checkname) {
                            er = true;
                            ermsg = ermsg + "Name does not conform<p class='ab'></p>";
                        }
                    }
                } else {
                    er = true;
                    ermsg = ermsg + "Tax Code Error<p class='ab'></p>";
                }

                if (er) {
                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                    document.getElementById('errorlarge').style.display = "block";
                    document.getElementById('errorlargetext').innerHTML = ermsg;
                    return false;
                } else {
                    unlockheavy();
                    document.getElementById('errorlargetext').innerHTML = "ERROR";
                    var sex = "";
                    var dn = cf.substring(9, 11).trim();
                    if (dn < 32) {
                        sex = "M";
                    }
                    if (dn > 40) {
                        sex = "F";
                        dn = dn - 40;
                        if (dn < 10) {
                            dn = "0" + dn;
                        }
                    }

                    var an = cf.substring(6, 8).trim();
                    var st1 = "19";
                    $.ajax({
                        async: false,
                        type: "POST",
                        url: "Operazioni_test?type=vercfanno&anno=" + an,
                        success: function (data) {
                            st1 = data;
                        }
                    });



                    var mo = cf.substring(8, 9).trim();
                    var datebirth = dn + "/" + formatMonthcf(mo) + "/" + st1 + an;
                    var codcom = cf.substring(11, 15).trim().toUpperCase();
                    var country = "";
                    var city = "";
                    var district = "---";
                    var found_country = false;
                    var found_city = false;
                    if (codcom.length > 1) {
                        var start = codcom.substring(0, 1).trim();
                        if (start === "Z") {
                            $.ajax({
                                async: false,
                                type: "POST",
                                url: "Query?type=querycountry&q=" + codcom,
                                success: function (data) {
                                    country = data;
                                    district = "EE";
                                    document.getElementById('heavy_pob_district_div').style.display = "";
                                    document.getElementById("heavy_pob_district_STR").style.display = "none";
                                    document.getElementById("heavy_pob_district_STR").value = "";
                                    $('#heavy_pob_country').val(country).change();
                                    document.getElementById("heavy_pob_city").value = $('#heavy_pob_country :selected').text();
                                    $("#heavy_pob_city").attr('readonly', 'readonly');
                                }
                            });
                        } else {
                            country = '<%=ln.getNazioneCodice("ITALIA")%>';
                            $.ajax({
                                async: false,
                                type: "POST",
                                url: "Query?type=querycodcom_city&q=" + codcom,
                                success: function (data) {
                                    city = data;
                                    document.getElementById("heavy_pob_city").value = city;
                                    $("#heavy_pob_city").attr('readonly', 'readonly');
                                }
                            });
                            $.ajax({
                                async: false,
                                type: "POST",
                                url: "Query?type=querycodcom_distr&q=" + codcom,
                                success: function (data) {
                                    district = data;
                                    document.getElementById('heavy_pob_district_div').style.display = "";
                                    document.getElementById("heavy_pob_district_STR").style.display = "none";
                                    document.getElementById("heavy_pob_district_STR").value = "";
                                }
                            });
                        }
                    }

                    $('#heavy_sex').val(sex).change();
                    disable_sel2('heavy_sex', 'form1');
                    //

                    $('#heavy_pob_date').datepicker().datepicker('setDate', datebirth);
                    $("#heavy_pob_date").attr('readonly', 'readonly');
                    $('#heavy_pob_country').val(country).change();
                    $('#heavy_pob_district').val(district).change();

                    disable_sel2('heavy_pob_country', 'form1');
                    disable_sel2('heavy_pob_district', 'form1');
                }
                verificaclient();
            }

            function blockheavy() {

                disable_sel2('heavy_country');
                //$('#heavy_sex').val('').trigger('change');
                disable_sel2('heavy_sex', 'form1');
                document.getElementById("heavy_city").disabled = true;
                $("#heavy_city").attr('readonly', 'readonly');
                //$('#heavy_city').val(' ').trigger('change');
                $("#heavy_address").attr('readonly', 'readonly');
                $("#heavy_zipcode").attr('readonly', 'readonly');
                document.getElementById('heavy_district').disabled = true;
                $("#heavy_district").attr('readonly', 'readonly');
                //$('#heavy_district').val(' ').trigger('change');
                $("#heavy_pob_city").attr('readonly', 'readonly');
                //$('#heavy_pob_district').val(' ').trigger('change');
                //$('#heavy_pob_country').val(' ').trigger('change');
                disable_sel2('heavy_pob_country', 'form1');
                $("#heavy_pob_date").attr('readonly', 'readonly');
                //$('#heavy_identcard').val(' ').trigger('change');
                disable_sel2('heavy_identcard', 'form1');
                //$('#heavy_pepI').val(' ').trigger('change');
                disable_sel2('heavy_pepI', 'form1');
                $("#heavy_numberidentcard").attr('readonly', 'readonly');

                document.getElementById("heavy_issuedateidentcard").disabled = true;
                $("#heavy_issuedateidentcard").attr('readonly', 'readonly');
                document.getElementById("heavy_exdateidentcard").disabled = true;
                $("#heavy_exdateidentcard").attr('readonly', 'readonly');

                $("#heavy_issuedbyidentcard").attr('readonly', 'readonly');
                $("#heavy_issuedplaceidentcard").attr('readonly', 'readonly');
                $("#heavy_email").attr('readonly', 'readonly');
                $("#heavy_phonenu").attr('readonly', 'readonly');
            }

            function unlockheavy() {

                enable_sel2('heavy_country');

                //$('#heavy_sex').val('').trigger('change');
                enable_sel2('heavy_sex', 'form1');
                document.getElementById("heavy_city").disabled = false;
                $('#heavy_city').removeAttr('readonly');

                $('#heavy_address').removeAttr('readonly');
                $('#heavy_zipcode').removeAttr('readonly');
                document.getElementById('heavy_district').disabled = false;
                $('#heavy_district').removeAttr('readonly');


                $("#heavy_pob_city").removeAttr('readonly');
                $("#heavy_pob_date").removeAttr('readonly');
                enable_sel2('heavy_pob_country', 'form1');
                enable_sel2('heavy_identcard', 'form1');
                $('#heavy_pepI').val('NO').trigger('change');
                enable_sel2('heavy_pepI', 'form1', true);
                $("#heavy_numberidentcard").removeAttr('readonly');
                document.getElementById("heavy_issuedateidentcard").disabled = false;
                $("#heavy_issuedateidentcard").removeAttr('readonly');
                document.getElementById("heavy_exdateidentcard").disabled = false;
                $("#heavy_exdateidentcard").removeAttr('readonly');

                $("#heavy_issuedbyidentcard").removeAttr('readonly');
                $("#heavy_issuedplaceidentcard").removeAttr('readonly');
                $("#heavy_email").removeAttr('readonly');
                $("#heavy_phonenu").removeAttr('readonly');
                document.getElementById('heavy_pob_district_div').style.display = "";
                document.getElementById('heavy_pob_district_STR').style.display = "none";
            }

            function readDoc(modal) {
                var docout = document.getElementById("documentReading").value;
                if (docout.indexOf("PASSPORT") !== -1 || docout.indexOf("IDENTITY CARD") !== -1) { //PASSAPORTO - IDENTITY CARD
                    docout = docout.split("START")[1].trim();
                    var surname = docout.split("Surname:")[1].trim().split("\n")[0].trim();
                    var name = docout.split("Forenames:")[1].trim().split("\n")[0].trim();
                    var sex = docout.split("Gender:")[1].trim().split("\n")[0].trim().substring(0, 1);
                    var datebirth = convertDate_1(docout.split("Date of Birth:")[1].trim().split("\n")[0].trim());
                    var exD = convertDate_2(docout.split("Expiry Date:")[1].trim().split("\n")[0].trim());
                    var dnu = docout.split("Doc. Number:")[1].trim().split("\n")[0].trim();
                    var iss = docout.split("Issuing State:")[1].trim().split("\n")[0].trim();

            <%for (int i = 0; i < array_country.size(); i++) {%>
                    var alphacode = '<%=array_country.get(i)[2]%>';
                    if (alphacode === iss) {
                        iss = "<%=array_country.get(i)[1]%>";
                    }
            <%}%>



                    var naz = "---";
                    if (docout.indexOf("Nationality:") !== -1) {
                        naz = docout.split("Nationality:")[1].trim().split("\n")[0].trim();
                        var country = "";
                        var found_country = false;
            <%for (int i = 0; i < array_country.size(); i++) {%>
                        var alphacode = '<%=array_country.get(i)[2]%>';
                        if (alphacode === naz) {
                            country = '<%=array_country.get(i)[0]%>';
                            found_country = true;
                        }
            <%}%>

                        var ita = '<%=ln.getNazioneCodice("ITALIA")%>';

                        if (document.getElementById('heavy_country').value === ita) {
                            country = ita;
                        }


                        if (document.getElementById('heavy_country').value === ita || country === ita) {
                            document.getElementById("heavy_pob_district_STR").style.display = "none";
                            document.getElementById("heavy_pob_district_STR").value = "";
                            document.getElementById('heavy_pob_district_div').style.display = "";
                        } else {
                            document.getElementById('heavy_pob_district_div').style.display = "none";
                            document.getElementById("heavy_pob_district_STR").style.display = "";
                            document.getElementById("heavy_pob_district_STR").value = "";
                        }
                    }
                    var doc = docout.split("Document:")[1].trim().split("\n")[0].trim();
                    var tdo = "";
                    var found_tdo = false;
            <%for (int i = 0; i < array_identificationCard.size(); i++) {%>
                    var robcode = '<%=array_identificationCard.get(i)[3]%>';
                    if (robcode === doc) {
                        tdo = '<%=array_identificationCard.get(i)[0]%>';
                        found_tdo = true;
                    }
            <%}%>


                    $('#heavy_sex').val(sex).change();
                    //disable_sel2('heavy_sex', 'form1');
                    document.getElementById("heavy_surname").value = surname;
                    document.getElementById("heavy_name").value = name;




                    $('#heavy_pob_date').datepicker().datepicker('setDate', datebirth);
                    if (found_country) {
                        $('#heavy_pob_country').val(country).change();
                        $('#heavy_country').val(country).change();
                        //disable_sel2('heavy_pob_country', 'form1');
                    }
                    var o = $("<option/>", {value: tdo, text: document.getElementById('DE_' + tdo).value});
                    $('#heavy_identcard').append(o);
                    $('#heavy_identcard').val(tdo).change();
                    //disable_sel2('heavy_identcard', 'form1');
                    document.getElementById("heavy_numberidentcard").value = dnu;
                    $('#heavy_exdateidentcard').datepicker().datepicker('setDate', exD);

                    document.getElementById("heavy_issuedbyidentcard").value = iss;
                    document.getElementById("heavy_issuedplaceidentcard").value = iss;





                } else {
                    //TESSERA SANITARIA
                    if (docout.indexOf("START") !== -1 && docout.indexOf("END") !== -1) {
                        docout = docout.split("START")[1].trim();
                        docout = docout.split("\n")[0].trim();
                        docout = docout.split("Codice")[1].trim();
                        docout = docout.split("fiscale:")[1].trim();
                        if (docout.length > 16) {
                            var cf = docout.substring(0, 16).trim();
                            var sex = "";
                            var dn = cf.substring(9, 11).trim();
                            if (dn < 32) {
                                sex = "M";
                            }
                            if (dn > 40) {
                                sex = "F";
                                dn = dn - 40;
                                if (dn < 10) {
                                    dn = "0" + dn;
                                }
                            }
                            var an = cf.substring(6, 8).trim();
                            var mo = cf.substring(8, 9).trim();
                            var datebirth = dn + "/" + formatMonthcf(mo) + "/" + "19" + an;
                            var namecompl = docout.substring(16).trim();
                            var surname = namecompl.split("  ")[0].trim();
                            var name = namecompl.split("  ")[1].trim();
                            var codcom = cf.substring(11, 15).trim();
                            var country = "";
                            var city = "";
                            var district = "";
                            var found_country = false;
                            var found_city = false;
                            if (codcom.length > 1) {
                                var start = codcom.substring(0, 1).trim();
                                if (start === "Z") {
                                    $.ajax({
                                        type: "POST",
                                        url: "Query?type=querycountry&q=" + codcom,
                                        success: function (data) {
                                            country = data;
                                            $('#heavy_pob_district').val('EE').change();
                                            disable_sel2('heavy_pob_district', 'form1');
                                            document.getElementById('heavy_pob_district_div').style.display = "";
                                            document.getElementById("heavy_pob_district_STR").style.display = "none";
                                            document.getElementById("heavy_pob_district_STR").value = "";
                                            $('#heavy_pob_country').val(country).change();
                                        }
                                    });
                                    document.getElementById('heavy_pob_district_div').style.display = "none";
                                    document.getElementById("heavy_pob_district_STR").style.display = "";
                                    document.getElementById("heavy_pob_district_STR").value = "";
                                } else {
                                    country = '<%=ln.getNazioneCodice("ITALIA")%>';
                                    $('#heavy_pob_country').val(country).change();
                                    $.ajax({
                                        type: "POST",
                                        url: "Query?type=querycodcom_city&q=" + codcom,
                                        success: function (data) {
                                            city = data;
                                            document.getElementById("heavy_pob_city").value = city;
                                            $("#heavy_pob_city").attr('readonly', 'readonly');
                                        }
                                    });
                                    $.ajax({
                                        type: "POST",
                                        url: "Query?type=querycodcom_distr&q=" + codcom,
                                        success: function (data) {
                                            district = data;
                                            //disable_sel2('heavy_pob_district', 'form1');
                                            document.getElementById('heavy_pob_district_div').style.display = "";
                                            document.getElementById("heavy_pob_district_STR").style.display = "none";
                                            document.getElementById("heavy_pob_district_STR").value = "";
                                            $('#heavy_pob_district').val(district).change();

                                        }
                                    });
                                }
                            }
                            document.getElementById("heavy_surname").value = surname;
                            document.getElementById("heavy_name").value = name;
                            document.getElementById("heavy_codfisc").value = cf;

                            $('#heavy_pob_date').datepicker().datepicker('setDate', datebirth);
                            $('#heavy_sex').val(sex).change();
                            //disable_sel2('heavy_sex', 'form1');
                            //disable_sel2('heavy_pob_country', 'form1');
                            checkcodfisc();
                        }

                    }
                }



                modificaOAMSurname(document.getElementById("heavy_surname"), null);
                modificaOAMSurname(document.getElementById("heavy_name"), null);



                dismiss(modal);
            }

            //change district nation
            function changedistrictpob() {
                var ita = '<%=ln.getNazioneCodice("ITALIA")%>';

                if (document.getElementById('heavy_pob_country').value === "") {
                    $('#heavy_pob_district').val(" ").change();
                    disable_sel2('heavy_pob_district', 'form1');
                } else {
                    if (document.getElementById('heavy_pob_country').value === ita) {
                        $('#heavy_pob_district').val("---").change();
                        enable_sel2('heavy_pob_district', 'form1');
                        document.getElementById('heavy_pob_district_div').style.display = "";
                        document.getElementById("heavy_pob_district_STR").style.display = "none";
                        document.getElementById("heavy_pob_district_STR").value = "";
                    } else {
                        $('#heavy_pob_district').val("EE").change();
                        disable_sel2('heavy_pob_district', 'form1');
                    }
                }
                ricercaclientestraniero(true);
            }

            function changecustomerKind(nostyle) {
                if (nostyle === "true") {

                } else {
                    document.getElementById('dataverified').style.display = 'none';
                }

                var data = $('#kind1 option:selected').val();
                var ud1 = data === undefined || data === null || data === '';

                var v1 = document.getElementById("customerKind").value;

                if (v1 !== "None") {
                    if ('<%=Constant.is_IT%>' === 'true') {
                        $('#heavy_identcard').val('---').trigger('change');
                    }
                    var showmod = "-1";
                    var dismod = "";

                    var thranag = "";
                    var maxweek = "";
                    var res = "";
                    var tipocli = "";
                    var area = "";
            <%for (int i = 0; i < array_custkind.size(); i++) {%>
                    var kind_controlla = '<%=array_custkind.get(i).getTipologia_clienti()%>';
                    if (v1 === kind_controlla) {
                        tipocli = '<%=array_custkind.get(i).getFg_tipo_cliente()%>';
                        area = '<%=array_custkind.get(i).getFg_area_geografica()%>';
                        thranag = '<%=array_custkind.get(i).getIp_max_singola_transazione()%>';
                        maxweek = '<%=array_custkind.get(i).getIp_max_settimanale()%>';
                        dismod = '<%=array_custkind.get(i).getStampa_autocertificazione()%>';
                        if (dismod === "1") {
                            showmod = '<%=array_custkind.get(i).getIp_soglia_extraCEE_certification()%>';
                        }
                    }
            <%}%>

                    document.getElementById('thranag').value = thranag;
                    document.getElementById('maxweek').value = maxweek;

                    disable_sel2('heavy_country');
                    enable_sel2('heavy_country');
                    document.getElementById('showmod').value = showmod;
                    if (tipocli === '20') { //PERSONA GIURIDICA
                        document.getElementById("custinfo_1").style.display = "none";
                        document.getElementById("custinfo_2").style.display = "";
                        document.getElementById("heavy_codfisc").disabled = false;
                        document.getElementById("buttoncheckcf").disabled = false;
                        document.getElementById("buttoncheckaeg").disabled = false;
                    } else {
                        if (area === '1') { //NORMALE ITALIA
                            //  blocco select italia
                            ricercaclientestraniero(false);
                            $('#heavy_country').empty().trigger('change');
            <%for (int j = 0; j < array_country_1.size(); j++) {%>
                            var o = $("<option/>", {value: "<%=array_country_1.get(j)[0]%>", text: "<%=array_country_1.get(j)[1]%>"});
                            $('#heavy_country').append(o);
            <%}%>
                            $('#heavy_country').val($('#heavy_country' + ' option:first-child').val()).trigger('change');
                            disable_sel2('heavy_country', 'form1');
                            document.getElementById("heavy_city_dis").value = "";
                            document.getElementById("heavy_city_dis").style.display = "none";
                            document.getElementById("heavy_city_div").style.display = "";
                            document.getElementById("zipcodelabel").style.display = "";
                            $('#heavy_city').select2({
                                ajax: {
                                    url: "Query?type=city_select",
                                    dataType: 'json',
                                    delay: 250,
                                    data: function (params) {
                                        return {
                                            q: params.term, // search term
                                            page: params.page
                                        };
                                    },
                                    processResults: function (data, params) {
                                        // parse the results into the format expected by Select2
                                        // since we are using custom formatting functions we do not need to
                                        // alter the remote JSON data, except to indicate that infinite
                                        // scrolling can be used
                                        params.page = params.page || 1;
                                        // !IMPORTANT! your every item in data.items has to have an .id property - this is the actual value that Select2 uses
                                        // Luckily the source data.items already have one
                                        return {
                                            results: data.items,
                                            pagination: {
                                                more: (params.page * 30) < data.total_count
                                            }
                                        };
                                    },
                                    cache: true
                                },
                                escapeMarkup: function (markup) {
                                    return markup; // let our custom formatter work
                                },
                                minimumInputLength: 1,
                                templateResult: function (repo) {
                                    if (repo.loading)
                                        return repo.text;
                                    return repo.full_name;
                                },
                                templateSelection: function (repo) {
                                    return repo.full_name || repo.text;
                                }
                            });
                            document.getElementById("heavy_district_dis").value = "";
                            document.getElementById("heavy_district_dis").style.display = "none";
                            document.getElementById("heavy_district_div").style.display = "";

                            $('#heavy_district').select2({
                                ajax: {
                                    url: "Query?type=district_select",
                                    dataType: 'json',
                                    delay: 250,
                                    data: function (params) {
                                        return {
                                            q: params.term, // search term
                                            page: params.page
                                        };
                                    },
                                    processResults: function (data, params) {
                                        // parse the results into the format expected by Select2
                                        // since we are using custom formatting functions we do not need to
                                        // alter the remote JSON data, except to indicate that infinite
                                        // scrolling can be used
                                        params.page = params.page || 1;
                                        // !IMPORTANT! your every item in data.items has to have an .id property - this is the actual value that Select2 uses
                                        // Luckily the source data.items already have one
                                        return {
                                            results: data.items,
                                            pagination: {
                                                more: (params.page * 30) < data.total_count
                                            }
                                        };
                                    },
                                    cache: true
                                },
                                escapeMarkup: function (markup) {
                                    return markup; // let our custom formatter work
                                },
                                minimumInputLength: 1,
                                templateResult: function (repo) {
                                    if (repo.loading)
                                        return repo.text;
                                    return repo.full_name;
                                },
                                templateSelection: function (repo) {
                                    return repo.full_name || repo.text;
                                }
                            });
                            document.getElementById("custinfo_2").style.display = "none";
                            document.getElementById("custinfo_1").style.display = "";
                            document.getElementById("heavy_codfisc").disabled = false;
                            document.getElementById("buttoncheckcf").disabled = false;
                            document.getElementById("buttoncheckaeg").disabled = false;
                            blockheavy();

                            document.getElementById("taxcodespan").style.display = "";
                            document.getElementById("heavy_districtspan").style.display = "";
                            document.getElementById("heavy_pob_districtspan").style.display = "";


                        } else if (area === '2') { //EUROPEO
                            ricercaclientestraniero(true);
                            document.getElementById("zipcodelabel").style.display = "none";
                            $('#heavy_country').empty().trigger('change');

                            var bloccare = '<%=Constant.is_UK%>' === 'true' || '<%=Constant.is_CZ%>' === 'true';

                            var o = $("<option/>", {value: "---", text: "None"});
                            if (!bloccare) {
                                $('#heavy_country').append(o);
                            }
            <%for (int j = 0; j < array_country_2.size(); j++) {%>
                            var o = $("<option/>", {value: "<%=array_country_2.get(j)[0]%>", text: "<%=array_country_2.get(j)[1]%>"});
                            $('#heavy_country').append(o);
            <%}%>
                            $('#heavy_country').val($('#heavy_country' + ' option:first-child').val()).trigger('change');
                            if (!bloccare) {
                                enable_sel2('heavy_country', 'form1');
                            } else {
                                disable_sel2('heavy_country', 'form1');
                            }
                            document.getElementById("heavy_city").disabled = true;
                            document.getElementById("heavy_city_div").style.display = "none";
                            document.getElementById("heavy_city_dis").style.display = "";
                            document.getElementById("heavy_district").disabled = true;
                            document.getElementById("heavy_district_div").style.display = "none";
                            document.getElementById("heavy_district_dis").style.display = "";
                            disable_sel2('heavy_pob_district', 'form1');
                            document.getElementById("heavy_pob_district_div").style.display = "none";
                            document.getElementById("heavy_pob_district_STR").style.display = "";

                            document.getElementById("custinfo_2").style.display = "none";
                            document.getElementById("custinfo_1").style.display = "";
                            document.getElementById("heavy_codfisc").value = '';
                            document.getElementById("heavy_codfisc").disabled = true;
                            document.getElementById("buttoncheckcf").disabled = true;
                            document.getElementById("buttoncheckaeg").disabled = true;
                            unlockheavy();

                            document.getElementById("taxcodespan").style.display = "none";
                            document.getElementById("heavy_districtspan").style.display = "none";
                            document.getElementById("heavy_pob_districtspan").style.display = "none";
                        } else if (area === '3') {


                            ricercaclientestraniero(true);
                            //EXTRAEURO
                            //document.getElementById("heavy_country").disabled = false;
                            $('#heavy_country').empty().trigger('change');
                            var o = $("<option/>", {value: "---", text: "None"});
                            $('#heavy_country').append(o);
            <%for (int j = 0; j < array_country_3.size(); j++) {%>
                            var o = $("<option/>", {value: "<%=array_country_3.get(j)[0]%>", text: "<%=array_country_3.get(j)[1]%>"});
                            $('#heavy_country').append(o);
            <%}%>
                            $('#heavy_country').val($('#heavy_country' + ' option:first-child').val()).trigger('change');
                            enable_sel2('heavy_country', 'form1');
                            document.getElementById("heavy_city").disabled = true;
                            document.getElementById("zipcodelabel").style.display = "none";
                            document.getElementById("heavy_city_div").style.display = "none";
                            document.getElementById("heavy_city_dis").style.display = "";
                            document.getElementById("heavy_district").disabled = true;
                            document.getElementById("heavy_district_div").style.display = "none";
                            document.getElementById("heavy_district_dis").style.display = "";
                            disable_sel2('heavy_pob_district', 'form1');
                            document.getElementById("heavy_pob_district_div").style.display = "none";
                            document.getElementById("heavy_pob_district_STR").style.display = "";
                            document.getElementById("custinfo_2").style.display = "none";
                            document.getElementById("custinfo_1").style.display = "";
                            document.getElementById("heavy_codfisc").value = '';
                            document.getElementById("heavy_codfisc").disabled = true;
                            document.getElementById("buttoncheckcf").disabled = true;
                            document.getElementById("buttoncheckaeg").disabled = true;
                            unlockheavy();

                            document.getElementById("taxcodespan").style.display = "none";
                            document.getElementById("heavy_districtspan").style.display = "none";
                            document.getElementById("heavy_pob_districtspan").style.display = "none";
                        }

                    }

                    loadkind('1');

                    loadkind('2');
                    loadkind('3');
                    loadkind('4');
                    loadkind('5');

                } else {
                    ricercaclientestraniero(false);
                }

                disableCZ('1');
            }

            //cambio cap in base alla città
            function selectcityDistrict(heavy_city, heavy_zipcode) {
                var s1 = document.getElementById(heavy_city);
                $.ajax({
                    type: "POST",
                    url: "Query?type=querycodcom_zip&q=" + s1.value,
                    success: function (data) {
                        var z1 = document.getElementById(heavy_zipcode);
                        z1.value = data;
                    }
                });
            }

            //verifica percentuale commissione
            function f_comperc(index) {
                var comperc = document.getElementById("comperc" + index);

                comperc.value = comperc.value.replace(/-/g, '');

                var kind = "kind" + index;
                var justify = "lowcommjus" + index;
                var threshold_standard = "";
                var max = "";
                var kind_value = document.getElementById(kind).value;
            <%for (int i = 0; i < array_figbuy.size(); i++) {%>
                var ki = '<%=array_figbuy.get(i).getSupporto()%>';
                if (ki === kind_value) {
                    threshold_standard = '<%=array_figbuy.get(i).getBuy_comm_soglia_causale()%>';
                    max = '<%=array_figbuy.get(i).getCommissione_acquisto()%>';
                }
            <%}%>

                var threshold = threshold_standard;
                if (document.getElementById("trfig" + index).style.display === ""
                        ||
                        document.getElementById("trfig" + index).style.display === "block") {
                    var dis_rate = document.getElementById("divrate" + index).style.display;
                    if (dis_rate === "none") {
                    } else {
                        var rate = $("#rate" + index).prop('selectedIndex');
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "Operazioni_test?type=verificalevelratepersoglia&indexrate=" + rate + "&max=" + max,
                            success: function (data) {
                                threshold = data;
                            }
                        });
                    }
                }


                if ('<%=Constant.is_IT%>' === 'true' && parseFloatRaf(comperc.value, separatorthousand, separatordecimal) <= parseFloatRaf(threshold, separatorthousand, separatordecimal)) {

                    document.getElementById(justify).disabled = false;
                    $('#' + justify).select2({
                        dropdownAutoWidth: true
                    });
                    var o = $("<option/>", {value: "", text: "None"});
                    $('#' + justify).append(o);
            <%for (int j = 0; j < array_undermincommjustify.size(); j++) {%>
                    var o = $("<option/>", {value: "<%=array_undermincommjustify.get(j)[0]%>", text: "<%=array_undermincommjustify.get(j)[1]%>"});
                    $('#' + justify).append(o);
            <%}%>
                    $('#' + justify).val($('#' + justify + ' option:first-child').val()).trigger('change');
                } else {
                    $('#' + justify).empty().trigger('change');
                    document.getElementById(justify).disabled = true;
                }

                formatValueDecimalMax(comperc, max, separatorthousand, separatordecimal);
                setvalue(index);
            }


            function disableCZ(index) {
                if ('<%=Constant.is_CZ%>' === 'true') {
                    document.getElementById('comperc' + index).value = "0" + separatordecimal + "00";
                    document.getElementById('comperc' + index).readOnly = true;
                    $('#kindfixcomm' + index).val(" ").trigger('change');
                    disable_sel2('kindfixcomm' + index, 'form1');
                    disable_sel2('bb' + index, 'form1');
                    disable_sel2('sb' + index, 'form1');
                }
            }

            function loadkind(index) {

                var data = $('#kind' + index + ' option:selected').val();
                var ud1 = data === undefined || data === null || data === '';

                if (!ud1) {
                    return false;
                }

                disableCZ(index);


                var kind_value = document.getElementById('customerKind').value;
                var kindres = "0";
            <%for (int i = 0; i < array_custkind.size(); i++) {%>
                var sc = '<%=array_custkind.get(i).getTipologia_clienti()%>';
                if (sc === kind_value) {
                    kindres = '<%=array_custkind.get(i).getFg_nazionalita()%>';
                }
            <%}%>





                var kind = 'kind' + index;
                $('#' + kind).select2({
                    dropdownAutoWidth: true
                });
                $('#' + kind).empty();
            <%for (int i = 0; i < array_figbuy.size(); i++) {%>
                var o = $("<option/>", {value: "<%=array_figbuy.get(i).getSupporto()%>", text: "<%=array_figbuy.get(i).getDe_supporto()%>"});
                if (kindres === "1") {
                    if (kindres === "<%=array_figbuy.get(i).getResidenti()%>") {
                        $('#' + kind).append(o);
                    }
                } else {
                    $('#' + kind).append(o);
                }
            <%}%>
                $('#' + kind).val($('#' + kind + ' option:first-child').val()).trigger('change');


                document.getElementById("quantity" + index).disabled = false;
                document.getElementById("quantity" + index).value = '1' + separatordecimal + '00';

                kindfixcomm(index);


            }

            function kindfixcomm(index) {
                var kind = 'kindfixcomm' + index;
                $('#' + kind).select2({
                    dropdownAutoWidth: true
                });
                var o = $("<option/>", {value: "None", text: "None"});
                $('#' + kind).append(o);
            <%for (int i = 0; i < array_kindcommissionefissa.size(); i++) {%>
                var o = $("<option/>", {value: "<%=array_kindcommissionefissa.get(i)[0]%>", text: "<%=array_kindcommissionefissa.get(i)[1]%>"});
                $('#' + kind).append(o);
            <%}%>
                $('#' + kind).val($('#' + kind + ' option:first-child').val()).trigger('change');

            }

            //  kind che imposta la percentuale di commissione - valute
            function changeKind(index) {
                var kind = "kind" + index;
                var comm = "comperc" + index;
                var figures = "figs" + index;
                var pos = "posvalue" + index;
                var posnum = "posnum" + index;
                var sbt = "sb_total" + index;
                var commperc_value = "0" + separatordecimal + "00";
                //var sb_total = "0" + separatordecimal + "00";
                var sb_total = '<%=array_figbuy.get(0).getSell_back_commission()%>';
                var kind_value = document.getElementById(kind).value;
            <%for (int i = 0; i < array_figbuy.size(); i++) {%>
                var ki = '<%=array_figbuy.get(i).getSupporto()%>';
                if (ki === kind_value) {
                    commperc_value = '<%=array_figbuy.get(i).getCommissione_acquisto()%>';
                }
            <%}%>

                document.getElementById(comm).value = commperc_value;
                document.getElementById(sbt).value = sb_total;

                formatValueDecimalMax(document.getElementById(comm), '100' + separatordecimal + '00', separatorthousand, separatordecimal);
                $('#' + figures).select2({
                    dropdownAutoWidth: true
                });
                $('#' + figures).empty().trigger('change');
                var def = $("<option/>", {value: "---", text: "None"});
                $('#' + figures).append(def);
            <%for (int j = 0; j < array_currency.size();
                        j++) {%>
            <%for (int i = 0; i < array_kind_currency_enabled.size(); i++) {%>
                var checkkind = '<%=array_kind_currency_enabled.get(i)[0]%>';
                if (checkkind === kind_value) {
                    var curvalue = '<%=array_kind_currency_enabled.get(i)[1]%>';
                    if (curvalue === '<%=array_currency.get(j).getCode()%>') {
                        var o = $("<option/>", {value: "<%=array_currency.get(j).getCode()%>",
                            text: "<%=array_currency.get(j).getCode()%> - <%=array_currency.get(j).getDescrizione()%>"});
                                            var fgeur = '<%=array_currency.get(j).getInternal_cur()%>';
                                            if (kind_value === '01' && fgeur === '1') {
                                            } else {
                                                $('#' + figures).append(o);
                                            }
                                        }
                                    }
            <%}
                }%>
                                    $('#' + figures).val($('#' + figures + ' option:first-child').val()).trigger('change');
                                    //04 - change advanced
                                    if (kind_value === '04') {

                                        document.getElementById(posnum).disabled = false;
                                        document.getElementById(pos).disabled = false;
                                        $('#' + pos).select2({
                                            dropdownAutoWidth: true
                                        });
                                        $('#' + pos).empty().trigger('change');
                                        var o1 = $("<option/>", {value: "...", text: "None"});
                                        $('#' + pos).append(o1);
            <%for (int j = 0; j < array_credit_card.size(); j++) {%>
                                        var o = $("<option/>", {value: "<%=array_credit_card.get(j)[0]%>", text: "<%=array_credit_card.get(j)[1]%>"});
                                        $('#' + pos).append(o);
            <%}%>
                                        $('#' + pos).val($('#' + pos + ' option:first-child').val()).trigger('change');
                                    } else {
                                        document.getElementById(posnum).value = "";
                                        document.getElementById(posnum).disabled = true;
                                        document.getElementById(pos).disabled = true;
                                        $('#' + pos).empty().trigger('change');
                                    }

                                    if (document.getElementById('typerate').value === 'UNLOCK') {



                                        var dis_rate = document.getElementById("divrate" + index).style.display;
                                        if (dis_rate === "none") {
                                            if (document.getElementById("fieldrate" + index) !== null) {
                                                document.getElementById("fieldrate" + index).style.display = "none";
                                            }
                                            if (document.getElementById("divrate" + index) !== null) {
                                                document.getElementById("divrate" + index).style.display = "";
                                            }
                                            //document.getElementById('unlockCode_final').value = '-';
                                            //document.getElementById('typerate').value = 'NORMAL';
                                        }
                                    }

                                    changefigs(index);
                                    f_comperc(index);
                                    verifykind();
                                }

                                function getmaxArrayCurr(kind, curr) {
            <%for (int i = 0; i < array_figbuy.size(); i++) {%>
                                    var ki_0 = '<%=array_figbuy.get(i).getSupporto()%>';
                                    if (ki_0 === kind) {
            <%for (int k = 0; k < array_rate_currency.size(); k++) {%>
                                        var cu_0 = '<%=array_rate_currency.get(k)[2]%>';
                                        if (cu_0 === curr) {



                                            return '<%=array_rate_currency.get(k)[0]%>';
                                        }
            <%}%>
                                    }
            <%}%>
                                    return "0";
                                }


                                function verificaRate(index, rate, kind, controvcheck, cu_val) {
                                    $.ajax({
                                        type: "POST",
                                        url: "Operazioni?type=verificaRate&tipotr=B&rate=" + rate + "&kind=" + kind + "&controvcheck=" + controvcheck + "&cur=" + cu_val,
                                        success: function (data) {
                                            var arrayJson = JSON.parse(data);
                                            if (arrayJson[0] === 'true') {


                                                $('#rate' + index).select2({
                                                    dropdownAutoWidth: true
                                                });
                                                $('#rate' + index).empty().trigger('change');
                                                var se = 0;
                                                for (var i = 1; i < arrayJson.length; i++) {
                                                    var iniu = arrayJson[i].split("#");
                                                    var ind = iniu[0];
                                                    var valore = iniu[1];
                                                    var descr = iniu[2];
                                                    var selected = iniu[3];
                                                    var o = $("<option/>", {value: valore, text: descr, dataindex: ind});
                                                    $('#rate' + index).append(o);
                                                    if (selected === 'SI') {
                                                        $('#rate' + index).val(valore).trigger('change');
                                                        se++;
                                                    }
                                                }
                                                if (se === 0) {
                                                    $('#rate' + index).val($('#rate' + index + ' option:first-child').val()).trigger('change');
                                                }
                                            }
                                        }
                                    });
                                }


                                //quantity che sceglie rate
                                function changequantity(index) {
                                    if (document.getElementById("figs" + index) === null
                                            || document.getElementById("figs" + index).value === "" ||
                                            document.getElementById("figs" + index).value === "---") {
                                        if (document.getElementById("quantity" + index) !== null) {
                                            document.getElementById("quantity" + index).value = "0" + separatordecimal + "00";
                                            document.getElementById("net" + index).value = "0" + separatordecimal + "00";
                                            document.getElementById("total" + index).value = "0" + separatordecimal + "00";
                                        }
                                        return;
                                    }


                                    var bbactive = false;

                                    var bbb = document.getElementById('bb' + index);
                                    if (bbb.value === "Y") {
                                        bbactive = true;
                                    }

                                    var quant = document.getElementById("quantity" + index);
                                    var kind = "kind" + index;
                                    var figures = "figs" + index;
                                    var rate = "rate" + index;
                                    var fx_com = "fxcomm" + index;
                                    var kindfixcomm = "kindfixcomm" + index;
                                    formatValueDecimal_1(quant, separatorthousand, separatordecimal);
                                    formatValueDecimal_2(quant, separatorthousand, separatordecimal, 12);
                                    var kindvalue = document.getElementById(kind).value;
                                    var cu_val = document.getElementById(figures).value;
                                    var quantitycheck = replacestringparam(quant.value, separatorthousand);
                                    var controvcheck = controv(parseFloatRaf(quantitycheck, separatorthousand, separatordecimal),
                                            parseFloatRaf(getmaxArrayCurr(kindvalue, cu_val), separatorthousand, separatordecimal, 8));
                                    //rate
                                    controvcheck = parseFloatRaf(controvcheck.toFixed(2), separatorthousand, separatordecimal);

                                    if (!bbactive) {
                                        //mantenere rate se già selezionato
                                        var data = $('#rate' + index + ' option:selected').val();
                                        verificaRate(index, data, kindvalue, controvcheck, cu_val);

                                        // fixed comm
                                        var startfx = 0.00;
                                        var sb = document.getElementById('sb' + index);
                                        var sb_disabled = $('#' + sb.id).prop('disabled');
                                        if (!sb_disabled) {
                                            if (sb.value === "Y") {
                                                startfx = parseFloatRaf(document.getElementById('sb_total' + index).value, separatorthousand, separatordecimal);
                                            }
                                        }
                                        var kindfixcomm_value = document.getElementById(kindfixcomm).value.trim();
                                        if (kindfixcomm_value === "" || kindfixcomm_value === "None") {
                                            var maxabs = 0;
                                            var maxval = 0;
                                            var found = false;
                                            var dis_rate = document.getElementById("divrate" + index).style.display;
                                            var rate = document.getElementById("rate" + index).value;
                                            if (dis_rate === "none") {
                                                rate = document.getElementById("fieldrate" + index).value;
                                            }
                                            var total = controv(parseFloatRaf(quantitycheck, separatorthousand, separatordecimal),
                                                    parseFloatRaf(rate, separatorthousand, separatordecimal, 8));
                                            total = parseFloatRaf(total.toFixed(2), separatorthousand, separatordecimal);


            <%for (int i = 0; i < array_fixcommrange.size(); i++) {%>
                                            var kind_ch = '<%=array_fixcommrange.get(i)[0]%>';
                                            if (kindvalue === kind_ch) {
                                                var qmin = '<%=array_fixcommrange.get(i)[1]%>';
                                                var qmax = '<%=array_fixcommrange.get(i)[2]%>';
                                                maxval = '<%=Utility.formatMysqltoDisplay(array_fixcommrange.get(i)[3])%>';
                                                maxabs = qmax;



                                                if (total >= parseFloatRaf(qmin, separatorthousand, separatordecimal) && total <= parseFloatRaf(qmax, separatorthousand, separatordecimal)) {
                                                    document.getElementById(fx_com).value = accounting.formatNumber((startfx + parseFloatRaf('<%=array_fixcommrange.get(i)[3]%>', separatorthousand, separatordecimal)) + "", 2, separatorthousand, separatordecimal);
                                                    found = true;
                                                }
                                            }
            <%}%>
                                            if (!found) {
                                                if (total >= parseFloatRaf(maxabs, separatorthousand, separatordecimal)) {
                                                    document.getElementById(fx_com).value = (startfx + maxval) + "";
                                                    formatValueDecimal_1(document.getElementById(fx_com), separatorthousand, separatordecimal);
                                                }
                                            }
                                        } else {
                                            changeFixcomm_kind(index);
                                        }

                                    } else {

                                        document.getElementById(fx_com).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("totperc" + index).value = "0" + separatordecimal + "00";
                                        //document.getElementById("quantity" + index).value = "0" + separatordecimal + "00";

                                    }

                                    setvalue(index);
                                }

                                //cambio valuta
                                function changefigs(index) {
                                    var valuecurrency = document.getElementById('figs' + index).value;
            <%for (int i = 0; i < array_currency.size(); i++) {%>
                                    var cod = '<%=array_currency.get(i).getCode()%>';
                                    if (cod === valuecurrency) {
                                        var ermsg = "<%=Utility.correggi(array_currency.get(i).getMessage())%>".trim();
                                        if (ermsg !== "") {
                                            document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                            document.getElementById('infolarge').style.display = "block";
                                            document.getElementById('infolargetext').innerHTML = ermsg;
                                        }
                                        if (document.getElementById('sb_val' + index) !== null) {
                                            document.getElementById('sb_val' + index).value = "<%=array_currency.get(i).getEnable_sellback()%>";
                                            if ('<%=array_currency.get(i).getEnable_sellback()%>' === "1") {
                                                enable_sel2('sb' + index, 'form1');
                                                if ($('#sb' + index).val() === "Y" || $('#sb' + index).val() === "F") {
                                                    $('#sb' + index).val('N').trigger('change');
                                                }
                                            } else {
                                                disable_sel2('sb' + index, 'form1');
                                                if ($('#sb' + index).val() === "Y" || $('#sb' + index).val() === "F") {
                                                    $('#sb' + index).val('N').trigger('change');
                                                }
                                            }
                                            enable_sel2('bb' + index, 'form1');
                                            if ($('#bb' + index).val() === "Y" || $('#bb' + index).val() === "F") {
                                                $('#bb' + index).val('N').trigger('change');
                                            }
                                        }



                                    }
            <%}%>


                                    if (document.getElementById('typerate').value === 'UNLOCK') {
                                        //ricalcolo
                                        var fieldratedest = "99" + separatorthousand + "999" + separatordecimal + "9999";
                                        $.ajax({
                                            type: "POST",
                                            async: false,
                                            url: "Query?type=getbcevalue&q=" + valuecurrency,
                                            success: function (data) {
                                                if (data !== null && data !== "") {
                                                    fieldratedest = data;
                                                }
                                            }
                                        });
                                        if (document.getElementById("fieldrate" + index) !== null) {
                                            document.getElementById("fieldrate" + index).style.display = "";
                                            document.getElementById("fieldrate" + index).value = fieldratedest;
                                            $("#fieldrate" + index).off('change');
                                            $("#fieldrate" + index).change(function () {
                                                var fieldratedest = "99" + separatorthousand + "999" + separatordecimal + "9999";
                                                $.ajax({
                                                    type: "POST",
                                                    async: false,
                                                    url: "Query?type=getbcevalue&q=" + document.getElementById('figs' + this.id.replace('fieldrate', '')).value,
                                                    success: function (data) {
                                                        if (data !== null && data !== "") {
                                                            fieldratedest = data;
                                                        }
                                                    }
                                                });
                                                if ('<%=Constant.is_CZ%>' === 'true') {
                                                    formatValueDecimalMaxlengthR(this,
                                                            parseFloatRaf(fieldratedest.toString(), separatorthousand, separatordecimal),
                                                            separatorthousand, separatordecimal, 8);
                                                } else {
                                                    formatValueDecimalMinlengthR(this,
                                                            parseFloatRaf(fieldratedest.toString(), separatorthousand, separatordecimal),
                                                            separatorthousand, separatordecimal, 8);
                                                }
                                                changequantity(this.id.replace('fieldrate', ''));
                                            });
                                        }
                                        if (document.getElementById("divrate" + index) !== null) {
                                            document.getElementById("divrate" + index).style.display = "none";
                                        }
                                    } else {

                                        var dis_rate = document.getElementById("divrate" + index).style.display;
                                        if (dis_rate === "none") {
                                            if (document.getElementById("fieldrate" + index) !== null) {
                                                document.getElementById("fieldrate" + index).style.display = "none";
                                            }
                                            if (document.getElementById("divrate" + index) !== null) {
                                                document.getElementById("divrate" + index).style.display = "";
                                            }
                                            //document.getElementById('unlockCode_final').value = '-';
                                            //document.getElementById('typerate').value = 'NORMAL';
                                        }
                                    }

                                    disableCZ(index);
                                    changequantity(index);
                                    setvalue(index);
                                }

                                function changeFixcomm_kind(index) {

                                    var startfx = 0.00;
                                    var sb = document.getElementById('sb' + index);
                                    var sb_disabled = $('#' + sb.id).prop('disabled');
                                    if (!sb_disabled) {
                                        if (sb.value === "Y") {
                                            startfx = parseFloatRaf(document.getElementById('sb_total' + index).value, separatorthousand, separatordecimal);
                                        }
                                    }


                                    var kindfixcomm = "kindfixcomm" + index;
                                    var fx_com = "fxcomm" + index;
                                    var kindfixcomm_value = document.getElementById(kindfixcomm).value.trim();
                                    if (kindfixcomm_value !== "" && kindfixcomm_value !== "None") {
            <%for (int i = 0; i < array_kindcommissionefissa.size(); i++) {%>
                                        var id_kind_fc = '<%=array_kindcommissionefissa.get(i)[0]%>';
                                        if (id_kind_fc === kindfixcomm_value) {
                                            document.getElementById(fx_com).value = accounting.formatNumber((startfx + parseFloatRaf('<%=array_kindcommissionefissa.get(i)[2]%>', separatorthousand, separatordecimal)) + "", 2, separatorthousand, separatordecimal);
                                        }
            <%}%>
                                    } else {
                                        var quant = document.getElementById("quantity" + index);
                                        formatValueDecimal_1(quant, separatorthousand, separatordecimal);
                                        var quantitycheck = replacestringparam(quant.value, separatorthousand);
                                        var dis_rate = document.getElementById("divrate" + index).style.display;

                                        var rate = document.getElementById("rate" + index).value;
                                        if (dis_rate === "none") {
                                            rate = document.getElementById("fieldrate" + index).value;
                                        }
                                        var total = controv(parseFloatRaf(quantitycheck, separatorthousand, separatordecimal),
                                                parseFloatRaf(rate, separatorthousand, separatordecimal, 8));

                                        total = new BigNumber(total.toString()).round(2, BigNumber.ROUND_HALF_EVEN).toFixed(2);


                                        var maxabs = 0;
                                        var maxval = 0;
                                        var found = false;
                                        var kindvalue = document.getElementById("kind" + index).value;
                                        if (kindvalue !== "None" && kindvalue !== "") {


            <%for (int i = 0; i < array_fixcommrange.size(); i++) {%>
                                            var kind_ch = '<%=array_fixcommrange.get(i)[0]%>';
                                            if (kindvalue === kind_ch) {
                                                var qmin = '<%=array_fixcommrange.get(i)[1]%>';
                                                var qmax = '<%=array_fixcommrange.get(i)[2]%>';
                                                maxval = '<%=array_fixcommrange.get(i)[3]%>';
                                                maxabs = qmax;
                                                if (total >= parseFloatRaf(qmin, separatorthousand, separatordecimal) && total <= parseFloatRaf(qmax, separatorthousand, separatordecimal)) {
                                                    document.getElementById(fx_com).value = accounting.formatNumber((startfx +
                                                            parseFloatRaf('<%=array_fixcommrange.get(i)[3]%>', separatorthousand, separatordecimal)) + "", 2, separatorthousand, separatordecimal);
                                                    found = true;
                                                }
                                            }
            <%}%>

                                            if (!found) {
                                                if (total >= parseFloatRaf(maxabs, separatorthousand, separatordecimal)) {
                                                    document.getElementById(fx_com).value = (startfx + maxval) + "";
                                                    formatValueDecimal_1(document.getElementById(fx_com), separatorthousand, separatordecimal);
                                                }
                                            }

                                            var bb = document.getElementById('bb' + index);
                                            var bb_disabled = $('#' + bb.id).prop('disabled');
                                            if (!bb_disabled) {
                                                if (bb.value === "Y" || bb.value === "F") {
                                                    document.getElementById(fx_com).value = "0" + separatordecimal + "00";
                                                    document.getElementById("comperc" + index).value = "0" + separatordecimal + "00";
                                                }
                                            }
                                        }
                                        // changequantity(index);
                                    }
                                    setvalue(index);
                                }

                                function enable_sb(index) {
                                    var bb = document.getElementById('bb' + index);
                                    var fc = document.getElementById('fidcode' + index);
                                    var sb = document.getElementById('sb' + index);
                                    var sb_disabled = $('#' + sb.id).prop('disabled');
                                    if (!sb_disabled) {
                                        if (sb.value === "Y" || sb.value === "F") {
                                            fc.disabled = true;
                                            disable_sel2(bb.id, 'form1');
                                        } else {
                                            //fc.disabled = true;
                                            enable_sel2(bb.id, 'form1');
                                        }
                                    }
                                    changequantity(index);
                                }

                                function enable_bb(index) {
                                    var bb = document.getElementById('bb' + index);
                                    var sb = document.getElementById('sb' + index);
                                    var fc = document.getElementById('fidcode' + index);
                                    var bb_disabled = $('#' + bb.id).prop('disabled');
                                    if (!bb_disabled) {
                                        var bb_val = $("#" + bb.id).val();
                                        if (bb_val === "Y" || bb_val === "F") {
//                                            $("#" + fc.id).removeAttr('disabled');
                                            fc.disabled = false;
                                            $('#' + sb.id).val($('#' + sb.id + ' option:first-child').val()).trigger('change');
                                            disable_sel2(sb.id, 'form1');
                                        } else {
                                            fc.disabled = true;
                                            if (document.getElementById('sb_val' + index).value === "1") {
                                                enable_sel2(sb.id, 'form1');
                                                $('#' + sb.id).val($('#' + sb.id + ' option:first-child').val()).trigger('change');
                                            }

                                            //enable_sel2('kind' + index, 'form1');
                                            //enable_sel2('figs' + index, 'form1');
                                            //enable_sel2('rate' + index, 'form1');
                                            //document.getElementById("fxcomm" + index).value = "0" + separatordecimal + "00";
                                            //document.getElementById("comperc" + index).value = "0" + separatordecimal + "00";
                                            //document.getElementById("comperc" + index).readOnly = false;
                                            //document.getElementById("net" + index).readOnly = false;
                                            //document.getElementById("fidcode" + index).readOnly = false;
                                            //enable_sel2('kindfixcomm' + index, 'form1');
                                            //$('#figs' + index).removeAttr("onchange");
                                            //$("#figs" + index).change(function () {
                                            //changefigs(index);
                                            //});
                                            //fc.value = "";
                                            //$("#" + fc.id).attr('disabled', 'disabled');
                                            //loadkind(index);
                                        }
                                    }
                                    changequantity(index);
                                }

                                // abilita fidelity code cliccando su bb
                                function enablever(index) {
                                    var verified = document.getElementById('bb' + index);
                                    var val = 'fidcode' + index;
                                    if (verified.checked) {
                                        document.getElementById(val).disabled = false;
                                        document.getElementById("fxcomm" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("totperc" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).readOnly = true;

                                    } else {
                                        enable_sel2('kind' + index, 'form1');
                                        enable_sel2('figs' + index, 'form1');
                                        enable_sel2('rate' + index, 'form1');
                                        document.getElementById("fxcomm" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).value = "0" + separatordecimal + "00";
                                        document.getElementById("comperc" + index).readOnly = false;
                                        document.getElementById("net" + index).readOnly = false;
                                        document.getElementById("fidcode" + index).readOnly = false;
                                        enable_sel2('kindfixcomm' + index, 'form1');

                                        $('#figs' + index).removeAttr("onchange");
                                        $("#figs" + index).change(function () {
                                            changefigs(index);
                                        });

                                        document.getElementById(val).value = "";
                                        document.getElementById(val).disabled = true;
                                        //document.getElementById("comperc" + index).readOnly = false;
                                        loadkind(index);
                                    }
                                    setvalue(index);
                                }

                                //net

                                function getfx(kindfixcomm_value, controv_1, index) {

                                    var fx_com = '0' + separatordecimal + '00';

                                    if (kindfixcomm_value !== "" && kindfixcomm_value !== "None") {
            <%for (int i = 0; i < array_kindcommissionefissa.size(); i++) {%>
                                        var id_kind_fc = '<%=array_kindcommissionefissa.get(i)[0]%>';
                                        if (id_kind_fc === kindfixcomm_value) {
                                            fx_com = '<%=array_kindcommissionefissa.get(i)[2]%>';
                                        }
            <%}%>
                                    } else {
                                        var maxabs = 0;
                                        var maxval = 0;
                                        var found = false;
                                        var kindvalue = document.getElementById("kind" + index).value;
            <%for (int i = 0; i < array_fixcommrange.size(); i++) {%>
                                        var kind_ch = '<%=array_fixcommrange.get(i)[0]%>';
                                        if (kindvalue === kind_ch) {
                                            var qmin = '<%=array_fixcommrange.get(i)[1]%>';
                                            var qmax = '<%=array_fixcommrange.get(i)[2]%>';
                                            maxval = '<%=array_fixcommrange.get(i)[3]%>';
                                            maxabs = qmax;
                                            if (controv_1 >= parseFloatRaf(qmin, separatorthousand, separatordecimal) && controv_1 <= parseFloatRaf(qmax, separatorthousand, separatordecimal)) {
                                                fx_com = '<%=array_fixcommrange.get(i)[3]%>';
                                                found = true;
                                            }
                                        }
            <%}%>
                                        if (!found) {
                                            if (controv_1 >= parseFloatRaf(maxabs, separatorthousand, separatordecimal)) {
                                                fx_com = maxval;
                                            }
                                        }

                                    }


                                    var sb = document.getElementById('sb' + index);



                                    var sb_disabled = $('#' + sb.id).prop('disabled');
                                    if (!sb_disabled) {
                                        if (sb.value === "Y" || sb.value === "F") {
                                            fx_com = parseFloatRaf(fx_com, separatorthousand, separatordecimal) +
                                                    parseFloatRaf(document.getElementById('sb_total' + index).value,
                                                            separatorthousand, separatordecimal);
                                            fx_com = fx_com + "";
                                        }
                                    }

                                    return fx_com;

                                }




                                function changeNet(index, fxc) {

                                    var net = document.getElementById("net" + index);

                                    if ($("#net" + index).attr('readonly') === 'readonly') {
                                    } else {


                                        formatValueDecimal_1(net, separatorthousand, separatordecimal);
                                        var netval = replacestringparam(net.value, separatorthousand);
                                        var dis_rate = document.getElementById("divrate" + index).style.display;
                                        var rate = document.getElementById("rate" + index).value;
                                        if (dis_rate === "none") {
                                            rate = document.getElementById("fieldrate" + index).value;
                                        }

                                        var comperc = replacestringparam(document.getElementById("comperc" + index).value, separatorthousand);
                                        var kindfixcomm_value = document.getElementById("kindfixcomm" + index).value.trim();
                                        var controv_1 = parseFloatRaf(netval, separatorthousand, separatordecimal) +
                                                controv_opposto(parseFloatRaf(netval, separatorthousand, separatordecimal),
                                                        (parseFloatRaf(comperc, separatorthousand, separatordecimal) / 100));
                                        var fx_com = '0' + separatordecimal + '00';
                                        if (fxc === undefined) {
                                            fx_com = getfx(kindfixcomm_value, controv_1, index);
                                        } else {
                                            fx_com = fxc;
                                        }

                                        var verified = document.getElementById('bb' + index);
                                        if (verified.tagName.toLowerCase() === "select") {
                                            var bb_disabled = $('#' + verified.id).prop('disabled');
                                            if (!bb_disabled) {
                                                if (verified.value === "Y" || verified.value === "F") {
                                                    fx_com = "0.00";
                                                    comperc = "0.00";
                                                }
                                            }
                                        } else {
                                            if (verified.checked) {
                                                fx_com = "0.00";
                                                comperc = "0.00";
                                            }
                                        }

                                        var q = 0;
//                                  
                                        if ('<%=operator%>' === "/") {

                                            var num = parseFloatRaf(netval, separatorthousand, separatordecimal) + parseFloatRaf(fx_com, separatorthousand, separatordecimal);
                                            var de1 = 1 / parseFloatRaf(rate, separatorthousand, separatordecimal, 8);
                                            var de2 = de1 * (parseFloatRaf(comperc, separatorthousand, separatordecimal) / 100);
                                            q = num / (de1 - de2);
                                        } else {

                                            var num = parseFloatRaf(netval, separatorthousand, separatordecimal) + parseFloatRaf(fx_com, separatorthousand, separatordecimal);
                                            var de1 = parseFloatRaf(rate, separatorthousand, separatordecimal, 8);
                                            var de2 = de1 * (parseFloatRaf(comperc, separatorthousand, separatordecimal) / 100);
                                            q = num / (de1 - de2);
                                        }

                                        var quant_fin = accounting.formatNumber(new BigNumber(q.toString()).round(2, BigNumber.ROUND_HALF_EVEN), 2, separatorthousand, separatordecimal);
                                        if (fxc === undefined) {

                                            var nt0 = 0.0;

                                            if ('<%=operator%>' === "/") {
                                                nt0 = q / parseFloatRaf(rate, separatorthousand, separatordecimal, 8);
                                            } else {
                                                nt0 = q * parseFloatRaf(rate, separatorthousand, separatordecimal, 8);
                                            }


                                            var newfx = getfx(kindfixcomm_value, nt0, index);
                                            if (newfx !== fx_com) {
                                                changeNet(index, newfx);
                                                return false;
                                            }
                                        }
                                        document.getElementById("quantity" + index).value = quant_fin;
                                        document.getElementById("fxcomm" + index).value = fx_com;
                                        formatValueDecimal_1(document.getElementById("fxcomm" + index), separatorthousand, separatordecimal);
//                                    changequantity(index);
                                        setvalue(index);

                                    }


                                }

                                // check date
                                function checkheavy_pob_date() {
                                    var pobdate = document.getElementById('heavy_pob_date').value.trim();
                                    if (moment(pobdate, 'DD/MM/YYYY').isValid()) {
                                        //var limitdate = moment().subtract(15, 'year');
                                        var limitdate = moment().subtract(16, 'year');
                                        var pobdate1 = moment(pobdate, 'DD/MM/YYYY', true);
                                        if (!limitdate.isSameOrAfter(pobdate1)) {
                                            return false;
                                        }
                                    } else {
                                        return false;
                                    }
                                    if (moment(pobdate, 'DD/MM/YYYY').isValid()) {
                                        var pobdate1 = moment(pobdate, 'DD/MM/YYYY', true).add(100, 'year');
                                        if (moment().isSameOrAfter(pobdate1)) {
                                            return false;
                                        } else {
                                            return true;
                                        }
                                    } else {
                                        return false;
                                    }
                                }

                                function checkheavy_issuedateidentcard() {
                                    var issuedate = document.getElementById('heavy_issuedateidentcard').value.trim();
                                    if (moment(issuedate, 'DD/MM/YYYY').isValid()) {
                                        var nowdate = moment();
                                        var issuedate1 = moment(issuedate, 'DD/MM/YYYY', true);
                                        var ch1 = nowdate.isSameOrAfter(issuedate1);
                                        if (ch1) {
                                            var pobdate = document.getElementById('heavy_pob_date').value.trim();
                                            if (moment(pobdate, 'DD/MM/YYYY').isValid()) {
                                                var pobdate1 = moment(pobdate, 'DD/MM/YYYY', true);
                                                var ch2 = issuedate1.isSameOrAfter(pobdate1);
                                                return ch2;
                                            }
                                        }
                                    }
                                    return false;
                                }

                                function checkheavy_exdateidentcard() {
                                    var exiday = document.getElementById('heavy_exdateidentcard').value.trim();
                                    if (moment(exiday, 'DD/MM/YYYY').isValid()) {
                                        var nowdate = moment(moment().format('DD/MM/YYYY'), 'DD/MM/YYYY', true);
                                        var exiday1 = moment(exiday, 'DD/MM/YYYY', true);
                                        var ch1 = exiday1.isSameOrAfter(nowdate);
                                        return ch1;
                                    }
                                    return false;
                                }



                                //set Value row
                                function setvalue(index) {
                                    if (document.getElementById("trfig" + index).style.display === "" || document.getElementById("trfig" + index).style.display === "block") {
                                        if (nation === "IT" || nation === "CZ") {
                                            document.getElementById("totalspread").innerHTML = '0' + separatordecimal + '00';
                                            document.getElementById("totalspreadv").value = document.getElementById("totalspread").innerHTML;
                                        }
                                        var quantity = replacestringparam(document.getElementById("quantity" + index).value, separatorthousand);
                                        var dis_rate = document.getElementById("divrate" + index).style.display;
                                        var rate = document.getElementById("rate" + index).value;
                                        if (dis_rate === "none") {
                                            rate = document.getElementById("fieldrate" + index).value;
                                        }



                                        var total = controv(
                                                parseFloatRaf(quantity, separatorthousand, separatordecimal),
                                                parseFloatRaf(rate, separatorthousand, separatordecimal, 8)
                                                );


                                        var total_VISUAL = new BigNumber(total.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                        if (checkValueCorrect(total_VISUAL)) {
                                            document.getElementById("total" + index).value = accounting.formatNumber(total_VISUAL, 2, separatorthousand, separatordecimal);
                                        } else {
                                            document.getElementById("total" + index).value = '0' + separatordecimal + '00';
                                        }
                                        var com_perc = replacestringparam(document.getElementById("comperc" + index).value, separatorthousand);
                                        var tot_perc = total * parseFloatRaf(com_perc, separatorthousand, separatordecimal) / 100;
                                        var tot_perc_VISUAL = new BigNumber(tot_perc.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                        if (checkValueCorrect(tot_perc_VISUAL)) {
                                            document.getElementById("totperc" + index).value = accounting.formatNumber(tot_perc_VISUAL, 2, separatorthousand, separatordecimal);
                                        } else {
                                            document.getElementById("totperc" + index).value = '0' + separatordecimal + '00';
                                        }

                                        //calcolo 
                                        var fx_com = document.getElementById("fxcomm" + index).value;
                                        //
                                        var tot_comm = tot_perc + parseFloatRaf(fx_com, separatorthousand, separatordecimal);
                                        var tot_comm_VISUAL = new BigNumber(tot_comm.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                        if (checkValueCorrect(tot_comm_VISUAL)) {
                                            document.getElementById("totcomm" + index).value = accounting.formatNumber(tot_comm_VISUAL, 2, separatorthousand, separatordecimal);
                                        } else {
                                            document.getElementById("totcomm" + index).value = '0' + separatordecimal + '00';
                                        }

                                        var net = parseFloatRaf(total_VISUAL, separatorthousand, separatordecimal) -
                                                parseFloatRaf(tot_comm_VISUAL, separatorthousand, separatordecimal);
                                        document.getElementById("roundvalue" + index).value = "0.00";
                                        var nation = '<%=nation%>';
                                        var r_st = '<%=rst%>';

                                        if (nation === "IT") {
                                            var out1 = round_and_split_ita(new BigNumber(net.toString()).round(2, BigNumber.ROUND_).toFixed(2), 5);
                                            net = new BigNumber(parseFloatRaf(out1[0], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                            var round_t = new BigNumber(parseFloatRaf(out1[1], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                            document.getElementById("roundvalue" + index).value = round_t;
                                        }
                                        if (nation === "CZ") {
                                            var payout_t = new BigNumber(net.toString()).round().toFixed(2);
                                            var round_t = new BigNumber((parseFloatRaf(payout_t, separatorthousand, separatordecimal) - net).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                            net = accounting.formatNumber(payout_t, 2, separatorthousand, separatordecimal);
                                            document.getElementById("roundvalue" + index).value = round_t;
                                        }

                                        if (nation === "GB") {
                                            var out1 = round_and_split_UK(new BigNumber(net.toString()).round(2, BigNumber.ROUND_).toFixed(2), r_st);
                                            net = new BigNumber(parseFloatRaf(out1[0], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                            var round_t = new BigNumber(parseFloatRaf(out1[1], separatorthousand, separatordecimal).toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2);
                                            document.getElementById("roundvalue" + index).value = round_t;
                                        }



                                        var net_VISUAL = new BigNumber(parseFloatRaf(net.toString(),
                                                separatorthousand, separatordecimal)).round(2, BigNumber.ROUND_CEIL);

                                        //var net_VISUAL = new BigNumber(net.toString()).round(2, BigNumber.ROUND_CEIL);
                                        if (checkValueCorrect(net_VISUAL)) {
                                            document.getElementById("net" + index).value = accounting.formatNumber(net_VISUAL, 2, separatorthousand, separatordecimal);
                                        } else {
                                            document.getElementById("net" + index).value = '0' + separatordecimal + '00';
                                        }
                                        if (nation === "IT" || nation === "CZ") {
                                            calcolaspread(index);
                                        }
                                    }
                                    //altri campi con somme totali

                                    setvaluetotal();
                                }

                                function calcolaspread(index) {
                                    if (document.getElementById("trfig" + index).style.display === "" || document.getElementById("trfig" + index).style.display === "block") {
                                        var quant = document.getElementById("quantity" + index).value;
                                        var dis_rate = document.getElementById("divrate" + index).style.display;
                                        var rate = $('#rate' + index).val();
                                        if (dis_rate === "none") {
                                            rate = parseFloatRaf(document.getElementById("fieldrate" + index).value, separatorthousand, separatordecimal);
                                        }
                                        if (parseFloatRaf(quant, separatorthousand, separatordecimal) > 0) {
                                            $.ajax({
                                                type: "POST",
                                                url: "Operazioni_test?type=get_spread",
                                                async: false,
                                                data: {
                                                    type: "get_spread",
                                                    t: "B",
                                                    q1: $('#quantity' + index).val(),
                                                    f1: $('#figs' + index).val(),
                                                    ki: $('#kind' + index).val(),
                                                    r1: rate
                                                },
                                                success: function (data) {
                                                    if (data !== "") {
                                                        var arrayJson = JSON.parse(data);
                                                        document.getElementById("spread" + index).value = arrayJson[1];
                                                        if (arrayJson[0] === "OK") {
                                                            var totalspread = 0.00;
                                                            for (var t = 1; t < 6; t++) {
                                                                if (document.getElementById("spread" + t).value !== null) {
                                                                    totalspread = totalspread + parseFloatRaf(document.getElementById("spread" + t).value, separatorthousand, separatordecimal);
                                                                }
                                                            }
                                                            document.getElementById("totalspread").innerHTML =
                                                                    accounting.formatNumber(new BigNumber(totalspread.toString()).round(2,
                                                                            BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                                            document.getElementById("totalspreadv").value = document.getElementById("totalspread").innerHTML;
                                                        } else {
                                                            if (arrayJson[0] !== "-") {
                                                                document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                                document.getElementById('errorlarge').style.display = "block";
                                                                document.getElementById('errorlargetext').innerHTML = arrayJson[0];
                                                                return false;
                                                            }
                                                        }
                                                    }
                                                }
                                            });
                                        }
                                    }
                                }


                                //total value
                                function setvaluetotal() {
                                    var roundvalue = 0.00;
                                    for (var t = 1; t < 6; t++) {
                                        if (document.getElementById("roundvalue" + t).value !== null && document.getElementById('trfig' + t).style.display === "") {
                                            roundvalue = roundvalue + parseFloatRaf(document.getElementById("roundvalue" + t).value, separatorthousand, separatordecimal);
                                        }
                                    }
                                    if (roundvalue > 0) {
                                        if ('<%=Constant.is_CZ%>' === 'true') {
                                            document.getElementById("round0").value = accounting.formatNumber(roundvalue, 2, separatorthousand, separatordecimal);
                                        } else {
                                            document.getElementById("round0").value = "- " + accounting.formatNumber(roundvalue, 2, separatorthousand, separatordecimal);
                                        }
                                    } else {
                                        document.getElementById("round0").value = accounting.formatNumber(roundvalue, 2, separatorthousand, separatordecimal);
                                    }

                                    var totalnet = 0.00;
                                    for (var t = 1; t < 6; t++) {
                                        if (document.getElementById("net" + t).value !== null && document.getElementById('trfig' + t).style.display === "") {
                                            totalnet = totalnet + parseFloatRaf(replacestringparam(document.getElementById("net" + t).value, separatorthousand), separatorthousand, separatordecimal);
                                        }
                                    }

                                    document.getElementById("totalnet").innerHTML = accounting.formatNumber(new BigNumber(totalnet.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    var total = 0.00;
                                    for (var t = 1; t < 6; t++) {
                                        if (document.getElementById("total" + t).value !== null && document.getElementById('trfig' + t).style.display === "") {
                                            total = total + parseFloatRaf(replacestringparam(document.getElementById("total" + t).value, separatorthousand), separatorthousand, separatordecimal);
                                        }
                                    }

                                    document.getElementById("total00").innerHTML = accounting.formatNumber(new BigNumber(total.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    document.getElementById("total0").value = accounting.formatNumber(new BigNumber(total.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    var total_fxcomm = 0.00;
                                    for (var t = 1; t < 6; t++) {
                                        if (document.getElementById("fxcomm" + t).value !== null && document.getElementById('trfig' + t).style.display === "") {
                                            total_fxcomm = total_fxcomm + parseFloatRaf(replacestringparam(document.getElementById("fxcomm" + t).value, separatorthousand), separatorthousand, separatordecimal);
                                        }
                                    }
                                    document.getElementById("fix0").value = accounting.formatNumber(new BigNumber(total_fxcomm.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    var total_perccomm = 0.00;
                                    for (var t = 1; t < 6; t++) {
                                        if (document.getElementById("totperc" + t).value !== null) {
                                            total_perccomm = total_perccomm + parseFloatRaf(replacestringparam(document.getElementById("totperc" + t).value, separatorthousand), separatorthousand, separatordecimal);
                                        }
                                    }
                                    document.getElementById("com0").value = accounting.formatNumber(new BigNumber(total_perccomm.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    var total_commission = 0.00;
                                    for (var t = 1; t < 6; t++) {
                                        if (document.getElementById("totcomm" + t).value !== null) {
                                            total_commission = total_commission + parseFloatRaf(replacestringparam(document.getElementById("totcomm" + t).value, separatorthousand), separatorthousand, separatordecimal);
                                        }
                                    }
                                    document.getElementById("commission0").value = accounting.formatNumber(new BigNumber(total_commission.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    document.getElementById("payout0").innerHTML = accounting.formatNumber(new BigNumber(totalnet.toString()).round(2, BigNumber.ROUND_HALF_UP).toFixed(2), 2, separatorthousand, separatordecimal);
                                    document.getElementById("payout1").value = document.getElementById("payout0").innerHTML;

                                    var total = document.getElementById('total0').value.trim();

                                    var sogliasuperata = "true";

                                    var selectedcurrency = $("#figs1").val();
                                    var quantitycurrency = document.getElementById('quantity1').value;

                                    $.ajax({
                                        async: false,
                                        type: "POST",
                                        url: "Operazioni_test?type=verificasoglianagrafica&total=" + total
                                                + "&soglia=" + document.getElementById('thranag').value.trim()
                                                + "&currency=" + selectedcurrency
                                                + "&quantity=" + quantitycurrency,
                                        success: function (data) {
                                            sogliasuperata = data;
                                        }
                                    });

                                    var sosp = false;
                                    if (document.getElementById("op_sos") !== null) {
                                        sosp = document.getElementById("op_sos").checked;
                                    }

                                    if ('<%=Constant.is_UK%>' === 'true' && '<%=Constant.newuk%>' === 'true') {
                                        enable_sel2('heavy_cz_country', 'form1');
                                        enable_sel2('heavy_sanctions', 'form1');
                                        enable_sel2('heavy_pep', 'form1');
                                        $("#heavy_transactionre").removeAttr('readonly');
                                        $("#heavy_moneysource").removeAttr('readonly');
                                        $("#heavy_occupation").removeAttr('readonly');
                                        $("#newuk_1").removeClass().addClass("fgsearch has-warning");
                                        $("#newuk_2").removeClass().addClass("fgsearch has-warning");
                                        $("#newuk_3").removeClass().addClass("fgsearch has-warning");
                                        $("#newuk_7").removeClass().addClass("fgsearch has-warning");
                                        $("#newuk_4").removeClass().addClass("fgsearch");
                                        $("#newuk_5").removeClass().addClass("fgsearch");
                                        $("#newuk_6").removeClass().addClass("fgsearch");
                                        $("#heavy_city_dis").removeAttr('readonly');
                                        unlockheavy();
                                    }

                                    if (sogliasuperata === "true" || sosp) {
                                        document.getElementById("showanag").style.display = "";
                                    } else {
                                        document.getElementById("showanag").style.display = "none";

                                        if ('<%=Constant.is_UK%>' === 'true' && '<%=Constant.newuk%>' === 'true') {
                                            var selectedcustomerKind = $("#customerKind").val();
                                            var nuovasogliasuperata = "true";
                                            $.ajax({
                                                async: false,
                                                type: "POST",
                                                url: "Operazioni_test?type=verificasoglianagraficaUK&total=" + total
                                                        + "&currency=" + selectedcurrency
                                                        + "&customerKind=" + selectedcustomerKind
                                                        + "&quantity=" + quantitycurrency,
                                                success: function (data) {
                                                    nuovasogliasuperata = data;
                                                }
                                            });

                                            if (nuovasogliasuperata === "true") {
                                                $("#newuk_1").removeClass().addClass("fgsearch has-error");
                                                $("#newuk_2").removeClass().addClass("fgsearch has-error");
                                                $("#newuk_3").removeClass().addClass("fgsearch has-error");
                                                $("#newuk_4").removeClass().addClass("fgsearch has-error");
                                                $("#newuk_5").removeClass().addClass("fgsearch has-error");
                                                $("#newuk_6").removeClass().addClass("fgsearch has-error");
                                                $("#newuk_7").removeClass().addClass("fgsearch has-error");

                                                document.getElementById('showanagNEWUK').value = "YES";
                                                blockheavy();

                                                $('#heavy_address').val('');
                                                $('#heavy_pob_city').val('');
                                                //$('#heavy_identcard').val('');
                                                $('#heavy_issuedbyidentcard').val('');
                                                $('#heavy_issuedplaceidentcard').val('');
                                                //$('#heavy_cz_country').empty().trigger('change');

                                                $("#heavy_city_dis").attr('readonly', 'readonly');
                                                $('#heavy_cz_country').val('---').trigger('change');
                                                disable_sel2('heavy_cz_country', 'form1');
                                                disable_sel2('heavy_sanctions', 'form1');
                                                disable_sel2('heavy_pep', 'form1');
                                                $("#heavy_transactionre").attr('readonly', 'readonly');
                                                $("#heavy_moneysource").attr('readonly', 'readonly');
                                                $("#heavy_occupation").attr('readonly', 'readonly');
                                                $("#heavy_pob_date").removeAttr('readonly');
                                                enable_sel2('heavy_identcard', 'form1');
                                                enable_sel2('heavy_pob_country', 'form1');
                                                $("#heavy_numberidentcard").removeAttr('readonly');
                                                document.getElementById("showanag").style.display = "";

                                                //enable_sel2('heavy_country', 'form1');
                                                //var o = $("<option/>", {value: "---", text: "None"});
                                                //$('#heavy_country').append(o);
                                                //$('#heavy_country').val('---').trigger('change');
                                                disable_sel2('heavy_country', 'form1');

                                            } else {
                                                document.getElementById('showanagNEWUK').value = "NO";
                                                document.getElementById("showanag").style.display = "none";
                                                blockheavy();
                                            }
                                        }
                                    }







                                    if ('<%=Constant.is_IT%>' === 'true' && document.getElementById("customerKind").value === "002") {
                                        unlockheavy();
                                        $("#heavy_pob_city").attr('readonly', 'readonly');
                                        $("#heavy_pob_date").attr('readonly', 'readonly');
                                        disable_sel2('heavy_sex', 'form1');
                                        disable_sel2('heavy_pob_district', 'form1');
                                        disable_sel2('heavy_pob_country', 'form1');
                                    }

                                    showmodallimit();

                                    var so_1 = parseFloatRaf('<%=so_1%>', separatorthousand, separatordecimal) *
                                            parseFloatRaf(document.getElementById('maxweek').value.trim(), separatorthousand, separatordecimal);

                                    if (parseFloatRaf(document.getElementById("total0").value, separatorthousand, separatordecimal)
                                            > so_1) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "You can not complete the transaction. The Total exceeds the Max Weekly Threshold (" + document.getElementById('maxweek').value.trim() + ")";
                                        return false;
                                    }

                                    //$('#heavy_identcard').val('---').trigger('change');
                                }


                                function checktrimestralUK() {

                                    var uscita = true;

                                    var showanagNEWUK = document.getElementById('showanagNEWUK').value;
                                    if (showanagNEWUK === 'YES') {
                                        //controllo se cliente già superato soglia aggregando i dati
                                        //imposto come anagrafica 'normale' vuota per i campi obbligatori
                                        document.getElementById('showanagVALUE').value = 'none';
                                        var heavy_surname = document.getElementById("heavy_surname");
                                        var heavy_name = document.getElementById("heavy_name");
                                        var heavy_pob_date = document.getElementById("heavy_pob_date");
                                        var heavy_identcard = document.getElementById("heavy_identcard");
                                        var heavy_pob_country = document.getElementById("heavy_pob_country");
                                        var heavy_cz_issuingcountry = document.getElementById("heavy_cz_issuingcountry");
                                        var heavy_numberidentcard = document.getElementById("heavy_numberidentcard");
                                        var customerKind = document.getElementById('customerKind');
                                        var total = document.getElementById('total0').value.trim();



                                        if (isemptyField(heavy_surname)
                                                || isemptyField(heavy_name)
                                                || isemptyField(heavy_pob_date)
                                                || isemptyField(heavy_pob_country)
                                                || isemptyField(heavy_identcard)
                                                || isemptyField(heavy_cz_issuingcountry)
                                                || isemptyField(heavy_numberidentcard))
                                        {
                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                            document.getElementById('errorlarge').style.display = "block";
                                            document.getElementById('errorlargetext').innerHTML = "Fields with a <span class='font-red'>RED</span> border must be completed for this transaction.";
                                            return false;
                                        } else {
                                            $.ajax({
                                                async: false,
                                                type: "POST",
                                                url: "Query?type=verificanewuk&co1=" + heavy_surname.value.trim() + "&na1=" + heavy_name.value.trim()
                                                        + "&nz1=" + heavy_pob_country.value.trim() + "&dn1=" + heavy_pob_date.value.trim() +
                                                        "&customerKind=" + customerKind.value.trim() + "&importo=" + total,
                                                success: function (data) {
                                                    if (data === "KO") {
                                                        uscita = false;

                                                        enable_sel2('heavy_cz_country', 'form1');
                                                        enable_sel2('heavy_sanctions', 'form1');
                                                        enable_sel2('heavy_pep', 'form1');
                                                        $("#heavy_transactionre").removeAttr('readonly');
                                                        $("#heavy_moneysource").removeAttr('readonly');
                                                        $("#heavy_occupation").removeAttr('readonly');
                                                        $("#newuk_1").removeClass().addClass("fgsearch has-warning");
                                                        $("#newuk_2").removeClass().addClass("fgsearch has-warning");
                                                        $("#newuk_3").removeClass().addClass("fgsearch has-warning");
                                                        $("#newuk_7").removeClass().addClass("fgsearch has-warning");
                                                        $("#newuk_4").removeClass().addClass("fgsearch");
                                                        $("#newuk_5").removeClass().addClass("fgsearch");
                                                        $("#newuk_6").removeClass().addClass("fgsearch");
                                                        $("#heavy_city_dis").removeAttr('readonly');
                                                        unlockheavy();

                                                        document.getElementById('showanagNEWUK').value = 'NO';
                                                        document.getElementById('showanagVALUE').value = 'YES';
                                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                        document.getElementById('errorlarge').style.display = "block";
                                                        document.getElementById('errorlargetext').innerHTML = "Complete KYC must be completed for this transaction.";


                                                    }
                                                }
                                            });
                                        }
                                    }
                                    return uscita;
                                    //return true;
                                }


                                function fieldobbl() {
                                    var verifica = document.getElementById('showanagVALUE').value !== 'none';
                                    //asdsadsadaasd

                                    var customerKind = document.getElementById("customerKind").value;
                                    if (customerKind !== "None") {
                                        var res = "";
                                        var tipocli = "";
            <%for (int i = 0; i < array_custkind.size(); i++) {%>
                                        var kind_controlla = '<%=array_custkind.get(i).getTipologia_clienti()%>';
                                        if (customerKind === kind_controlla) {
                                            res = '<%=array_custkind.get(i).getFg_nazionalita()%>';
                                            tipocli = '<%=array_custkind.get(i).getFg_tipo_cliente()%>';
                                        }
            <%}%>


                                        if (tipocli === '10') { //utente


                                            if (res === "1") { //residente ita
                                                var heavy_surname = document.getElementById("heavy_surname");
                                                var heavy_sex = document.getElementById("heavy_sex");
                                                var heavy_name = document.getElementById("heavy_name");
                                                var heavy_codfisc = document.getElementById("heavy_codfisc");
                                                var heavy_pepI = document.getElementById("heavy_pepI");
                                                var heavy_address = document.getElementById("heavy_address");
                                                var heavy_country = document.getElementById("heavy_country");
                                                var heavy_zipcode = document.getElementById("heavy_zipcode");
                                                var heavy_city = document.getElementById("heavy_city");




                                                var heavy_district = document.getElementById("heavy_district");
                                                var heavy_pob_city = document.getElementById("heavy_pob_city");
                                                var heavy_pob_district_STR = document.getElementById("heavy_pob_district_STR");
                                                var heavy_pob_district = document.getElementById("heavy_pob_district");
                                                var heavy_pob_country = document.getElementById("heavy_pob_country");
                                                var heavy_pob_date = document.getElementById("heavy_pob_date");
                                                var heavy_identcard = document.getElementById("heavy_identcard");
                                                var heavy_numberidentcard = document.getElementById("heavy_numberidentcard");
                                                var heavy_issuedateidentcard = document.getElementById("heavy_issuedateidentcard");
                                                var heavy_exdateidentcard = document.getElementById("heavy_exdateidentcard");
                                                var heavy_issuedbyidentcard = document.getElementById("heavy_issuedbyidentcard");
                                                var heavy_issuedplaceidentcard = document.getElementById("heavy_issuedplaceidentcard");
                                                var heavy_cz_country = document.getElementById("heavy_cz_country");
                                                var heavy_cz_issuingcountry = document.getElementById("heavy_cz_issuingcountry");
                                                var heavy_transactionre = document.getElementById('heavy_transactionre');
                                                var heavy_moneysource = document.getElementById('heavy_moneysource');
                                                var heavy_occupation = document.getElementById('heavy_occupation');

                                                if ('<%=Constant.is_IT%>' === 'false') {
                                                    if (!verifica) {
                                                        return true;
                                                    } else {
                                                        var pepcz = $("#heavy_pep").val();
                                                        var pepvuoto = false;
                                                        if (pepcz === "NO") {
                                                        } else {
                                                            if (isemptyField(document.getElementById('pep_position'))
                                                                    || isemptyField(document.getElementById('pep_country'))) {
                                                                pepvuoto = true;
                                                            }
                                                        }

                                                        heavy_city = document.getElementById("heavy_city_dis");

                                                        if (isemptyField(heavy_surname)
                                                                || isemptyField(heavy_sex)
                                                                || isemptyField(heavy_name)
                                                                || isemptyField(heavy_cz_country)
                                                                || isemptyField(heavy_city)
                                                                || isemptyField(heavy_address)
                                                                || isemptyField(heavy_country)
                                                                || isemptyField(heavy_pob_city)
                                                                || isemptyField(heavy_pob_country)
                                                                || isemptyField(heavy_pob_date)
                                                                || isemptyField(heavy_identcard)
                                                                || isemptyField(heavy_numberidentcard)
                                                                || isemptyField(heavy_cz_issuingcountry)
                                                                || isemptyField(heavy_issuedateidentcard)
                                                                || isemptyField(heavy_exdateidentcard)
                                                                || isemptyField(heavy_transactionre)
                                                                || isemptyField(heavy_moneysource)
                                                                || isemptyField(heavy_occupation)
                                                                || pepvuoto
                                                                || isemptyField(heavy_issuedbyidentcard)
                                                                || isemptyField(heavy_issuedplaceidentcard)) {
                                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                            document.getElementById('errorlarge').style.display = "block";
                                                            document.getElementById('errorlargetext').innerHTML = "Fields with <span class='font-red'>*</span> must be completed.";
                                                            return false;
                                                        }

                                                        //altri controlli

                                                    }
                                                } else {

                                                    if (isemptyField(heavy_surname) || isemptyField(heavy_sex) || isemptyField(heavy_name) || isemptyField(heavy_codfisc) || isemptyField(heavy_pepI) || isemptyField(heavy_city) ||
                                                            isemptyField(heavy_address) || isemptyField(heavy_country) || isemptyField(heavy_district) || isemptyField(heavy_pob_city) ||
                                                            (isemptyField(heavy_pob_district_STR) && isemptyField(heavy_pob_district))
                                                            || isemptyField(heavy_pob_country) || isemptyField(heavy_pob_date) || isemptyField(heavy_identcard) || isemptyField(heavy_numberidentcard) ||
                                                            isemptyField(heavy_issuedateidentcard) || isemptyField(heavy_exdateidentcard) ||
                                                            isemptyField(heavy_issuedbyidentcard) || isemptyField(heavy_issuedplaceidentcard) || isemptyField(heavy_zipcode)) {
                                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                        document.getElementById('errorlarge').style.display = "block";
                                                        document.getElementById('errorlargetext').innerHTML = "Fields with <span class='font-red'>*</span> must be completed.";
                                                        return false;
                                                    }
                                                }



                                            } else if (res === "2") {

                                                var heavy_surname = document.getElementById("heavy_surname");
                                                var heavy_sex = document.getElementById("heavy_sex");
                                                var heavy_name = document.getElementById("heavy_name");
                                                var heavy_pepI = document.getElementById("heavy_pepI");
                                                var heavy_address = document.getElementById("heavy_address");
                                                var heavy_country = document.getElementById("heavy_country");
                                                var heavy_pob_city = document.getElementById("heavy_pob_city");
                                                var heavy_pob_country = document.getElementById("heavy_pob_country");
                                                var heavy_pob_date = document.getElementById("heavy_pob_date");
                                                var heavy_identcard = document.getElementById("heavy_identcard");
                                                var heavy_numberidentcard = document.getElementById("heavy_numberidentcard");
                                                var heavy_issuedateidentcard = document.getElementById("heavy_issuedateidentcard");
                                                var heavy_exdateidentcard = document.getElementById("heavy_exdateidentcard");
                                                var heavy_issuedbyidentcard = document.getElementById("heavy_issuedbyidentcard");
                                                var heavy_issuedplaceidentcard = document.getElementById("heavy_issuedplaceidentcard");

                                                var heavy_transactionre = document.getElementById('heavy_transactionre');
                                                var heavy_moneysource = document.getElementById('heavy_moneysource');
                                                var heavy_occupation = document.getElementById('heavy_occupation');
                                                var heavy_cz_country = document.getElementById("heavy_cz_country");
                                                var heavy_cz_issuingcountry = document.getElementById("heavy_cz_issuingcountry");

                                                if ('<%=Constant.is_IT%>' === 'false') {
                                                    if (!verifica) {
                                                        return true;
                                                    } else {
                                                        var pepcz = $("#heavy_pep").val();
                                                        var pepvuoto = false;
                                                        if (pepcz === "NO") {
                                                        } else {
                                                            if (isemptyField(document.getElementById('pep_position'))
                                                                    || isemptyField(document.getElementById('pep_country'))) {
                                                                pepvuoto = true;
                                                            }
                                                        }

                                                        if (isemptyField(heavy_surname)
                                                                || isemptyField(heavy_sex)
                                                                || isemptyField(heavy_name)
                                                                || isemptyField(heavy_cz_country)
                                                                || isemptyField(heavy_cz_country)
                                                                || isemptyField(heavy_address)
                                                                || isemptyField(heavy_country)
                                                                || isemptyField(heavy_pob_city)
                                                                || isemptyField(heavy_pob_country)
                                                                || isemptyField(heavy_pob_date)
                                                                || isemptyField(heavy_identcard)
                                                                || isemptyField(heavy_numberidentcard)
                                                                || isemptyField(heavy_cz_issuingcountry)
                                                                || isemptyField(heavy_exdateidentcard)
                                                                || isemptyField(heavy_issuedateidentcard)
                                                                || isemptyField(heavy_transactionre)
                                                                || isemptyField(heavy_moneysource)
                                                                || pepvuoto
                                                                || isemptyField(heavy_occupation)
                                                                || isemptyField(heavy_issuedbyidentcard)
                                                                || isemptyField(heavy_issuedplaceidentcard)) {
                                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                            document.getElementById('errorlarge').style.display = "block";
                                                            document.getElementById('errorlargetext').innerHTML = "Fields with <span class='font-red'>*</span> must be completed.";
                                                            return false;
                                                        }

                                                        //altri controlli

                                                    }
                                                } else {


                                                    if (isemptyField(heavy_surname)
                                                            || isemptyField(heavy_sex)
                                                            || isemptyField(heavy_name)
                                                            || isemptyField(heavy_pepI)
                                                            || isemptyField(heavy_address)
                                                            || isemptyField(heavy_country)
                                                            || isemptyField(heavy_pob_city)
                                                            || isemptyField(heavy_pob_country)
                                                            || isemptyField(heavy_pob_date)
                                                            || isemptyField(heavy_identcard)
                                                            || isemptyField(heavy_numberidentcard)
                                                            || isemptyField(heavy_issuedateidentcard)
                                                            || isemptyField(heavy_exdateidentcard)
                                                            || isemptyField(heavy_issuedbyidentcard)
                                                            || isemptyField(heavy_issuedplaceidentcard)) {
                                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                        document.getElementById('errorlarge').style.display = "block";
                                                        document.getElementById('errorlargetext').innerHTML = "Fields with <span class='font-red'>*</span> must be completed.";
                                                        return false;
                                                    }

                                                    var heavy_pob_district = document.getElementById("heavy_pob_district");
                                                    if (heavy_pob_country.value === "<%=Constant.codnaz%>" && isemptyField(heavy_pob_district)) {
                                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                        document.getElementById('errorlarge').style.display = "block";
                                                        document.getElementById('errorlargetext').innerHTML = "Field 'District' (Place of Birth) must be completed.";
                                                        return false;
                                                    }


                                                    var heavy_city_dis = document.getElementById("heavy_city_dis");
                                                    if (isemptyField(heavy_city_dis)) {
                                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                        document.getElementById('errorlarge').style.display = "block";
                                                        document.getElementById('errorlargetext').innerHTML = "Field 'City' must be completed.";
                                                        return false;
                                                    }
                                                }


                                            } else if (res === "3") {
                                                var heavy_surname = document.getElementById("heavy_surname").value.trim();
                                                var heavy_sex = document.getElementById("heavy_sex").value.trim();
                                                var heavy_name = document.getElementById("heavy_name").value.trim();
                                                var heavy_codfisc = document.getElementById("heavy_codfisc").value.trim();
                                                var heavy_city = document.getElementById("heavy_city").value.trim();
                                                var heavy_pepI = document.getElementById("heavy_pepI").value.trim();
                                                var heavy_address = document.getElementById("heavy_address").value.trim();
                                                var heavy_country = document.getElementById("heavy_country").value.trim();
                                                var heavy_district = document.getElementById("heavy_district").value.trim();
                                                var heavy_pob_city = document.getElementById("heavy_city_dis").value.trim();
                                                var heavy_pob_district_STR = document.getElementById("heavy_pob_district_STR").value.trim();
                                                var heavy_pob_district = document.getElementById("heavy_pob_district").value.trim();
                                                var heavy_pob_country = document.getElementById("heavy_pob_country").value.trim();
                                                var heavy_pob_date = document.getElementById("heavy_pob_date").value.trim();
                                                var heavy_identcard = document.getElementById("heavy_identcard").value.trim();
                                                var heavy_numberidentcard = document.getElementById("heavy_numberidentcard").value.trim();
                                                var heavy_issuedateidentcard = document.getElementById("heavy_isasuedateidentcard").value.trim();
                                                var heavy_exdateidentcard = document.getElementById("heavy_exdateidentcard").value.trim();
                                                var heavy_issuedbyidentcard = document.getElementById("heavy_issuedbyidentcard").value.trim();
                                                var heavy_issuedplaceidentcard = document.getElementById("heavy_issuedplaceidentcard").value.trim();
                                                var heavy_pob_district = document.getElementById("heavy_pob_district");

                                                if (isempty(heavy_surname) || isempty(heavy_sex) || isempty(heavy_name) || isempty(heavy_codfisc) || isempty(heavy_pepI) ||
                                                        isempty(heavy_address) || isempty(heavy_country) || isempty(heavy_district) || isempty(heavy_pob_city) || isempty(heavy_city) ||
                                                        (isempty(heavy_pob_district_STR) && isempty(heavy_pob_district))
                                                        || isempty(heavy_pob_country) || isempty(heavy_pob_date) || isempty(heavy_identcard) || isempty(heavy_numberidentcard) ||
                                                        isempty(heavy_issuedateidentcard) || isempty(heavy_exdateidentcard) ||
                                                        isempty(heavy_issuedbyidentcard) || isempty(heavy_issuedplaceidentcard)) {
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = "Fields with <span class='font-red'>*</span> must be completed.";
                                                    return false;
                                                }
                                                var heavy_pob_district = document.getElementById("heavy_pob_district");
                                                if (heavy_pob_country.value === "<%=Constant.codnaz%>" && isemptyField(heavy_pob_district)) {
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = "Field 'District' (Place of Birth) must be completed.";
                                                    return false;
                                                }

                                                var heavy_city_dis = document.getElementById("heavy_city_dis");
                                                if (isemptyField(heavy_city_dis)) {
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = "Field 'City' must be completed.";
                                                    return false;
                                                }
                                            }

                                        } else {        //  company

                                        }
                                    } else {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "Fields with <span class='font-red'>*</span> must be completed.";
                                        return false;
                                    }
                                    //if(tipocli === ""){

                                    //}
                                    return true;
                                }

                                function datachecked() {

                                    var d = document.getElementById('dataverified').style.display.trim();
                                    if (d === "") {
                                        if (!document.getElementById('verdat').checked) {
                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                            document.getElementById('errorlarge').style.display = "block";
                                            document.getElementById('errorlargetext').innerHTML = "Field 'The data has been verified' must be checked.";
                                            return false;
                                        }
                                    }
                                    return true;
                                }

                                function controllatilloccupato() {
                                    var occ = "true";
                                    $.ajax({
                                        async: false,
                                        type: "POST",
                                        url: "Operazioni_test?type=controllaoccupato_till&q=" + document.getElementById('idopentillv').value.trim(),
                                        success: function (data) {
                                            occ = data;
                                        }
                                    });
                                    if (occ === "true") {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "Warning! Operation not permitted. You have an operation pending (Open/Close, Internal/External transfer, Transaction Change), before proceeding you MUST first finish that operation.";
                                        return false;
                                    } else if (occ === "true1") {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "Warning! Operation not permitted. The till is already closed.";
                                        return false;
                                    }
                                    return true;
                                }


                                function controllanetto() {
                                    for (var t = 1; t < 6; t++) {

                                        if (document.getElementById("trfig" + t).style.display === "") {
                                            if (!document.getElementById("net" + t).disabled) {
                                                var n1 = parseFloatRaf(document.getElementById("net" + t).value, separatorthousand, separatordecimal);
                                                if (n1 <= 0) {
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = "Error! Net value for Figures #" + t
                                                            + " must be greater than zero. Check this value.";
                                                    return false;
                                                }
                                            }
                                        }
                                    }
                                    return true;
                                }

                                function controllanazionecliente() {

                                    var ck = document.getElementById("customerKind").value;
                                    var na = document.getElementById("heavy_country").value;

                                    if (ck === "001" || ck === "009") {
                                        if (na === "<%=Constant.codnaz%>") {
                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                            document.getElementById('errorlarge').style.display = "block";
                                            document.getElementById('errorlargetext').innerHTML = "Please, choose a different country of residence - Italy not allowed";
                                            return false;
                                        }
                                    }
                                    return true;
                                }

                                function contcf() {

                                    if ('<%=Constant.is_IT%>' === 'false') {
                                        return true;
                                    }

                                    var customerKind = document.getElementById("customerKind").value.trim();
                                    if (customerKind !== "002") {
                                        return true;
                                    }
                                    var er = false;
                                    var ermsg = "";
                                    var cf = document.getElementById("heavy_codfisc").value.trim().toUpperCase();
                                    document.getElementById("heavy_codfisc").value = cf;
                                    if (cf === "") {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "Tax Code Error<p class='ab'></p>";
                                        return false;
                                    }
                                    var surname = document.getElementById("heavy_surname").value.trim().toUpperCase();
                                    var name = document.getElementById("heavy_name").value.trim().toUpperCase();
                                    var checksurname = getStringSurname(surname);
                                    var checkname = getStringName(name);
                                    if (checkCF(cf)) {
                                        if (checksurname !== 'XXX') {
                                            if (cf.substring(0, 3) !== checksurname) {
                                                er = true;
                                                ermsg = ermsg + "Surname does not conform<p class='ab'></p>";
                                            }
                                        }
                                        if (checkname !== 'XXX') {
                                            if (cf.substring(3, 6) !== checkname) {
                                                er = true;
                                                ermsg = ermsg + "Name does not conform<p class='ab'></p>";
                                            }
                                        }
                                    } else {
                                        er = true;
                                        ermsg = ermsg + "Tax Code Error<p class='ab'></p>";
                                    }
                                    if (er) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = ermsg;
                                        return false;
                                    }
                                    return true;
                                }


                                function verificaBB_final() {
                                    var esito = true;
                                    for (var t = 1; t < 6; t++) {
                                        var field = document.getElementById('fidcode' + t);
                                        if (!field.disabled) {
                                            var val = field.value.trim();
                                            if (val !== "") {
                                                $.ajax({
                                                    async: false,
                                                    type: "POST",
                                                    url: "Query?type=queryfidelitycode&q=" + val,
                                                    success: function (data) {
                                                        if (data !== "") {
                                                            var arrayJson = JSON.parse(data);
                                                            esito = arrayJson.length > 0;
                                                        } else {
                                                            esito = false;
                                                        }
                                                    }
                                                });
                                            } else {
                                                esito = false;
                                            }
                                        }
                                    }

                                    if (!esito) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "Fidelity code incorrect. Check the entered value.";
                                    }

                                    return esito;
                                }


                                function verifica_personalnumberCZ(VER) {
                                    if (VER !== 'false' && '<%=Constant.is_IT%>' === 'true') {
                                        $('#heavy_identcard').val('---').trigger('change');
                                    }
                                    if ('<%=Constant.is_CZ%>' === 'true') {
                                        if (document.getElementById('showanagVALUE').value !== 'none') {
                                            var nazione1 = $("#heavy_country").val();
                                            var nazione2 = $("#heavy_cz_country").val();
                                            if (nazione1 === '051' || nazione1 === '169' || nazione2 === '051' || nazione2 === '169') {
                                                document.getElementById('heavy_pno1OBBL').style.display = '';
                                                return true;
                                            }
                                            document.getElementById('heavy_pno1OBBL').style.display = 'none';
                                        }
                                    }
                                    return false;
                                }

                                function personalnumberCZ() {
                                    var dacontrollare = verifica_personalnumberCZ('false');
                                    if (dacontrollare) {
                                        if (isemptyField(document.getElementById('heavy_pno1'))) {
                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                            document.getElementById('errorlarge').style.display = "block";
                                            document.getElementById('errorlargetext').innerHTML = "The field 'Personal No.' must be entered.";
                                            return false;
                                        }
                                    }
                                    return true;
                                }

                                function verifica_WK_TI() {
                                    var exit = true;
                                    var wk1_d = $('#welc').prop('disabled');
                                    var wk1_v = false;
                                    if (!wk1_d) {
                                        wk1_v = $("#welc").prop('checked');
                                    }
                                    var to1_d = $('#fidel').prop('disabled');
                                    var to1_v = false;
                                    if (!to1_d) {
                                        to1_v = $("#fidel").prop('checked');
                                    }
                                    if (wk1_v || to1_v) {
                                        $.ajax({
                                            async: false,
                                            type: "POST",
                                            url: "Query?type=check_quantity_WK&c1=" + wk1_v +
                                                    "&q1=WELCOMEKIT&c2=" + to1_v +
                                                    "&q2=TOPITACARD&idopentillv=" + document.getElementById('idopentillv').value.trim(),
                                            success: function (data) {
                                                if (data !== "") {
                                                    exit = data === 'true';
                                                }
                                            }
                                        });
                                    }

                                    if (!exit) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        if (wk1_v) {
                                            document.getElementById('errorlargetext').innerHTML =
                                                    "The required quantity of 'Welcome Kit' is not available.";
                                        } else {
                                            document.getElementById('errorlargetext').innerHTML =
                                                    "The required quantity of 'Top Italy Card' is not available.";
                                        }
                                    }
                                    return exit;
                                }

                                function finalcheck() {

                                    document.getElementById('showanagVALUE').value = document.getElementById('showanag').style.display;

                                    var v_WK = verifica_WK_TI();
                                    if (!v_WK) {
                                        return false;
                                    }

                                    var trUK = checktrimestralUK();
                                    if (!trUK) {
                                        return false;
                                    }

                                    var punto19 = personalnumberCZ();
                                    if (!punto19) {
                                        return false;
                                    }

                                    var cc1 = checkweekly();
                                    if (!cc1) {
                                        return false;
                                    }

                                    var bb_0 = verificaBB_final();
                                    if (!bb_0) {
                                        return false;
                                    }

                                    var codfi = contcf();
                                    if (!codfi) {
                                        return false;
                                    }

                                    var cnet = controllanetto();
                                    if (!cnet) {
                                        return false;
                                    }


                                    var noc = controllanazionecliente();
                                    if (!noc) {
                                        return false;
                                    }


                                    var ti1 = controllatilloccupato();
                                    if (!ti1) {
                                        return false;
                                    }

                                    var cc1 = verifycctype();
                                    if (!cc1) {
                                        return false;
                                    }

                                    var dch = datachecked();
                                    if (!dch) {
                                        return false;
                                    }

                                    var er = false;
                                    var ermsg = "";

                                    var lcj = verifylowcommjus();
                                    if (!lcj) {
                                        return false;
                                    }

                                    var ki = verifykind();
                                    if (!ki) {
                                        return false;
                                    }

                                    var vercc = verifyccnumber();
                                    if (!vercc) {
                                        return false;
                                    }

                                    var verfi = verifyfigsvalue();
                                    if (!verfi) {
                                        return false;
                                    }

                                    var fo = fieldobbl();
                                    if (!fo) {
                                        return false;
                                    }

                                    var qu = checkquantitytill_BUY();
                                    if (!qu) {
                                        er = true;
                                        ermsg = ermsg + "You do not have enough currency for the Payout in this Till.<p class='ab'></p>";
                                    }


                                    var csq = checksizescurrency_new();
                                    if (!csq) {
                                        return false;
                                    }













                                    if (document.getElementById('customerKind').value === "003") {
                                        var company = document.getElementById('company').value;
                                        if (company === "") {
                                            er = true;
                                            ermsg = ermsg + "'Company' must be selected<p class='ab'></p>";
                                        }
                                    } else {

                                        var verifica = document.getElementById('showanagVALUE').value !== 'none';

                                        if (verifica) {
                                            var ch1 = checkheavy_pob_date();
                                            if (!ch1) {
                                                er = true;
                                                ermsg = ermsg + "Date of birth error<p class='ab'></p>";
                                            }
                                            //issue date > date birth - issue date < now
                                            var ch2 = checkheavy_issuedateidentcard();
                                            if (!ch2) {
                                                er = true;
                                                ermsg = ermsg + "Issue date error<p class='ab'></p>";
                                            }
                                            // expire day > now
                                            var ch3 = checkheavy_exdateidentcard();
                                            if (!ch3) {
                                                er = true;
                                                ermsg = ermsg + "Expiration date error<p class='ab'></p>";
                                            }
                                            var ch4 = checkEmail(document.getElementById("heavy_email").value.trim());
                                            if (!ch4) {
                                                er = true;
                                                ermsg = ermsg + "Email error<p class='ab'></p>";
                                            }
                                        }


                                        var so_1 = parseFloatRaf('<%=so_1%>', separatorthousand, separatordecimal) *
                                                parseFloatRaf(document.getElementById('maxweek').value.trim(), separatorthousand, separatordecimal);

                                        if (parseFloatRaf(document.getElementById("total0").value, separatorthousand, separatordecimal)
                                                >
                                                so_1) {
                                            er = true;
                                            ermsg = ermsg + "You can not complete the transaction. The Total exceeds the Max Weekly Threshold ("
                                                    + document.getElementById('maxweek').value.trim() + ")<p class='ab'></p>";
                                        }

                                    }


                                    if (er) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = ermsg;
                                        return false;
                                    } else {

                                        sanctions();


                                        return true;
                                    }

                                }

                                function checkEmail(email) {
                                    if (email !== "") {
                                        var emailFilter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
                                        //var v1 = validate.single(email, {presence: true, email: true});
                                        //if (undefined !== v1) {
                                        if (!emailFilter.test(email)) {
                                            return false;
                                        }
                                    }
                                    return true;
                                }


                                function verifica_1558() {
                                    var cf = document.getElementById('heavy_codfisc').value;
                                    var co1 = document.getElementById('heavy_surname').value.trim();
                                    var na1 = document.getElementById('heavy_name').value.trim();
                                    var nz1 = document.getElementById('heavy_pob_country').value.trim();
                                    var dn1 = document.getElementById('heavy_pob_date').value.trim();

                                    var loya = '---';
                                    if ('<%=Constant.is_IT%>' === 'true') {
                                        loya = document.getElementById("loya").value.trim();
                                    }

                                    $.ajax({
                                        type: "POST",
                                        url: "Query?type=list_OPERATION_client&cf=" + cf + "&co1=" + co1 + "&na1=" + na1 + "&nz1=" + nz1 + "&dn1=" + dn1 + "&loya=" + loya,
                                        success: function (data) {
                                            if (data !== "") {
                                                var arrayJson = JSON.parse(data);

                                                if (arrayJson[0] === 'false') {
                                                } else {

                                                    document.getElementById('infotra').className = document.getElementById('infotra').className + " in";
                                                    document.getElementById('infotra').style.display = "block";
                                                    document.getElementById('infotratext').innerHTML = arrayJson[1];

                                                    document.getElementById('infolarge').className = "modal fade";
                                                    document.getElementById('infolarge').style.display = "none";
                                                }
                                            }
                                        }
                                    });
                                }

                                function verificaclient() {
                                    var oldclient = '0';
                                    var heavy_codfisc = document.getElementById('heavy_codfisc').value;
                                    if (heavy_codfisc !== "") {
                                        $.ajax({
                                            async: false,
                                            type: "POST",
                                            url: "Query?type=verificaclient&ti=B&q=" + heavy_codfisc,
                                            success: function (data) {
                                                if (data !== "") {
                                                    var arrayJson = JSON.parse(data);
                                                    if (arrayJson.length > 0) {
                                                        document.getElementById('dataverified').style.display = '';
                                                        document.getElementById('heavy_surname').value = arrayJson[0];
                                                        document.getElementById('heavy_name').value = arrayJson[1];
                                                        $('#heavy_country').val(arrayJson[2]).trigger('change');

                                                        if (arrayJson[18] !== "-") {
                                                            var o = $("<option/>", {value: arrayJson[3], text: arrayJson[18]});
                                                            $('#heavy_city').append(o);
                                                            $('#heavy_city').val($('#heavy_city option:first-child').val()).trigger('change');
                                                        }


                                                        if (arrayJson[19] !== "-") {
                                                            var o = $("<option/>", {value: arrayJson[6], text: arrayJson[19]});
                                                            $('#heavy_district').append(o);
                                                            $('#heavy_district').val($('#heavy_district option:first-child').val()).trigger('change');
                                                        }
                                                        var o = $("<option/>", {value: arrayJson[7], text: document.getElementById('DE_' + arrayJson[7]).value});
                                                        $('#heavy_identcard').append(o);
                                                        $('#heavy_identcard').val(arrayJson[7]).trigger('change');

                                                        $('#heavy_pepI').val(arrayJson[20]).trigger('change');

                                                        $("#heavy_issuedateidentcard").removeAttr('readonly');
                                                        document.getElementById('heavy_numberidentcard').value = arrayJson[8];

                                                        $('#heavy_issuedateidentcard').datepicker().datepicker('setDate', arrayJson[9]);
                                                        $('#heavy_exdateidentcard').datepicker().datepicker('setDate', arrayJson[10]);
                                                        document.getElementById('heavy_issuedbyidentcard').value = arrayJson[11];
                                                        document.getElementById('heavy_issuedplaceidentcard').value = arrayJson[12];
                                                        document.getElementById('heavy_email').value = arrayJson[13];
                                                        document.getElementById('heavy_phonenu').value = arrayJson[14];
                                                        if (arrayJson[15] !== "-") {
                                                            for (var x = 1; x < 6; x++) {
                                                                document.getElementById('comperc' + x).value = arrayJson[15];
                                                                formatValueDecimal_1(document.getElementById('comperc' + x), separatorthousand, separatordecimal);
                                                                f_comperc(x);
                                                            }
                                                        }
                                                        document.getElementById('heavy_address').value = arrayJson[4];
                                                        document.getElementById('heavy_zipcode').value = arrayJson[5];

                                                        if (arrayJson[21] !== "") {
                                                            document.getElementById('loya').value = arrayJson[21];
                                                        }
                                                        document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                                        document.getElementById('infolarge').style.display = "block";
                                                        document.getElementById('infolargetext').innerHTML = 'The customer has been recognized. Please confirm the data.';
                                                        oldclient = arrayJson[16];
                                                    }
                                                }
                                                document.getElementById('oldclient').value = oldclient;
                                            }
                                        });
                                    }

                                    verifica_1558();
                                }

                                function convertDate_0(dataing) {
                                    if (dataing.includes("-")) {
                                        var dd = dataing.split("-")[2].trim();
                                        var mm = dataing.split("-")[1].trim();
                                        var aa = dataing.split("-")[0].trim();
                                        var out = dd + "/" + mm + "/" + aa;
                                        return out;
                                    }
                                    return "";
                                }

                                function heavyczh(nation) {
                                    if (nation === 'IT') {
                                        document.getElementById('pepITA').style.display = '';
                                    }
                                }



                                function changepersonalne_czh() {
                                    if (document.getElementById('heavy_pno0').value === 'YES') {
                                        document.getElementById('czh2').style.display = '';
                                    } else {
                                        document.getElementById('czh2').style.display = 'none';
                                        document.getElementById('heavy_pno1').value = '';
                                    }
                                }




                                //page load
                                function loadpage() {
                                    $('#largelogin').on('shown.bs.modal', function () {
                                        $('#passwordlargelogin').focus();
                                    });
                                    $('#largereaddoc').on('shown.bs.modal', function () {
                                        $('#documentReading').focus();
                                    });
                                    online();
                                    loadtill();
                                    changetill();
                                    changecustomerKind();
                                    inputvirgola();
                                    heavyczh('<%=nation%>');
                                    //loadkind('1');
                                    kindfixcomm('1');
                                    //changeKind('1');
                                    //changefigs('1');
                                    //changequantity('1');
                                    //changeFixcomm_kind('1');
                                    //setvalue('1');

                                    checkesito();
                                    //ricercaclientestraniero(true);
                                    load_doclist();
                                    //kindfixcomm('1');
                                }

                                function checkquantitytill_BUY() {

                                    var exit = false;
                                    $.ajax({
                                        async: false,
                                        type: "POST",
                                        url: "Query?type=checkquantitytill_BUY&idopentillv=" + document.getElementById('idopentillv').value.trim()
                                                + "&payout1=" + document.getElementById('payout1').value.trim(),
                                        success: function (data) {
                                            if (data !== "") {
                                                exit = data === "true";
                                            }
                                        }
                                    });
                                    return exit;
                                }

                                function subform() {
                                    document.getElementById('butconf').disabled = true;
                                    $("#butconf").html("<i class='fa fa-circle-o-notch fa-spin'></i> Sending...");
                                    //controlli
                                    if (finalcheck()) {
                                    } else {
                                        document.getElementById('butconf').disabled = false;
                                        document.getElementById('butconf').innerHTML = "<i class='fa fa-save'></i> Confirm Transaction";
                                        return false;
                                    }
                                    return true;
                                }

                                function verifyccnumber() {
                                    var err = false;
                                    for (var ind = 1; ind < 6; ind++) {
                                        if (document.getElementById("kind" + ind) !== null) {
                                            if (document.getElementById("trfig" + ind).style.display === "") {
                                                var ki = document.getElementById("kind" + ind).value.trim();
                                                if (ki === "04") {
                                                    var posnum = document.getElementById("posnum" + ind).value.trim();
                                                    if (posnum === "" || posnum.length !== 4) {
                                                        err = true;
                                                        break
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (err) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML =
                                                "Field 'CC Number' must be completed for Kind 'Cash Advance'.";
                                        return false;
                                    }
                                    return true;
                                }

                                function verifycctype() {
                                    var err = false;
                                    for (var ind = 1; ind < 6; ind++) {
                                        if (document.getElementById("kind" + ind) !== null) {
                                            if (document.getElementById("trfig" + ind).style.display === "") {
                                                var ki = document.getElementById("kind" + ind).value.trim();
                                                if (ki === "04") {
                                                    var posvalue = document.getElementById("posvalue" + ind).value.trim();
                                                    if (posvalue === "" || posvalue === "...") {
                                                        err = true;
                                                        break
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (err) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML =
                                                "Field 'POS' must be completed for Kind 'Cash Advance'.";
                                        return false;
                                    }
                                    return true;
                                }



                                function verifyfigsvalue() {
                                    var err = false;
                                    for (var ind = 1; ind < 6; ind++) {
                                        if (document.getElementById("figs" + ind) !== null) {
                                            if (document.getElementById("trfig" + ind).style.display === "") {
                                                var fig = document.getElementById("figs" + ind).value.trim();
                                                if (fig === "---") {
                                                    err = true;
                                                    break
                                                }

                                            }
                                        }
                                    }
                                    if (err) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML =
                                                "Field 'Figures' must be completed.";
                                        return false;
                                    }
                                    return true;
                                }

                                function verifykind() {
                                    var err = false;
                                    var init = "01";
                                    init = document.getElementById("kind1").value.trim();
                                    if (init !== "") {
                                        for (var ind = 2; ind < 6; ind++) {
                                            if (document.getElementById("kind" + ind) !== null) {
                                                if (document.getElementById("trfig" + ind).style.display === "") {
                                                    if (init === "01" || init === "02" || init === "03") {
                                                        if (document.getElementById("kind" + ind).value.trim() === "04") {
                                                            err = true;
                                                            break
                                                        }
                                                    }
                                                    if (init === "04") {
                                                        if (document.getElementById("kind" + ind).value.trim() === "01"
                                                                || document.getElementById("kind" + ind).value.trim() === "02"
                                                                || document.getElementById("kind" + ind).value.trim() === "03") {
                                                            err = true;
                                                            break
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (err) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML =
                                                "Kind 'Cash Advance' can not be associated with others Kind.";
                                        return false;
                                    }
                                    return true;
                                }


                                function verifylowcommjus() {

                                    if ('<%=Constant.is_CZ%>' === 'true') {
                                        return true;
                                    }

                                    var err = false;
                                    for (var ind = 1; ind < 6; ind++) {
                                        if (document.getElementById("lowcommjus" + ind) !== null) {
                                            if (document.getElementById("trfig" + ind).style.display === "") {
                                                var lowcommjus = document.getElementById("lowcommjus" + ind).disabled;
                                                if (!lowcommjus) {
                                                    var lowcommjus_v = document.getElementById("lowcommjus" + ind).value.trim();
                                                    if (lowcommjus_v === "") {
                                                        err = true;
                                                        break
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    if (err) {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML =
                                                "Field 'Low Com. Justify' must be completed.";
                                        return false;
                                    }
                                    return true;
                                }


                                function showmodallimit() {
                                    var i = document.getElementById('total0').value.trim();
                                    var showmod = document.getElementById('showmod').value.trim();
                                    if (parseFloatRaf(showmod, separatorthousand, separatordecimal) > 0) {
                                        if (parseFloatRaf(i, separatorthousand, separatordecimal) >= parseFloatRaf(showmod, separatorthousand, separatordecimal)) {
                                            document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                            document.getElementById('infolarge').style.display = "block";
                                            document.getElementById('infolargetext').innerHTML = "<%=Utility.correggi(head.getTxt_alert_threshold_1())%>";
                                        }
                                    }
                                }


                                function checkweekly() {
                                    var exit = false;
                                    var company = document.getElementById('company').value.trim();

                                    var n = document.getElementById('heavy_name').value.trim();
                                    var c = document.getElementById('heavy_surname').value.trim();
                                    var d = document.getElementById('heavy_pob_date').value.trim();
                                    var naz = document.getElementById('heavy_pob_country').value.trim();
                                    var t = document.getElementById('customerKind').value.trim();
                                    var cf = document.getElementById('heavy_codfisc').value.trim();
                                    var i = document.getElementById('total0').value.trim();
                                    var heavy_identcard = document.getElementById('heavy_identcard').value.trim();
                                    $.ajax({
                                        async: false, type: "POST",
                                        url: "Query?type=sogliasetclient&company=" + company + "&n=" + n + "&c=" + c + "&d=" + d + "&naz=" +
                                                naz + "&cf=" + cf + "&t=" + t + "&i=" + i + "&doc=" + heavy_identcard,
                                        success: function (data) {
                                            if (data !== "") {
                                                var arrayJson = JSON.parse(data);
                                                if (arrayJson[0] === "false1") {
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = arrayJson[1];
                                                    exit = false;
                                                } else if (arrayJson[0] === "false3") {
                                                    var msg = arrayJson[1];
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = msg;
                                                    exit = false;
                                                } else if (arrayJson[0] === "false2") {
                                                    var msg = "";
                                                    for (var e = 1; e < arrayJson.length; e++) {
                                                        msg = msg + arrayJson[e] + "<p class='ab'></p>";
                                                    }
                                                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                    document.getElementById('errorlarge').style.display = "block";
                                                    document.getElementById('errorlargetext').innerHTML = msg;
                                                    exit = false;
                                                } else {
                                                    exit = true;
                                                }
                                            }
                                        }
                                    });
                                    return exit;
                                }

                                function checksizescurrency_new() {

                                    var pay = "01";
                                    var total = document.getElementById('payout0').innerHTML;
                                    var localcur = '<%=local_cur%>';

                                    var link = "Query?type=checksizecurrency&pay=" + pay + "&total=" + total + "&localcur=" + localcur + "&";

                                    for (var ind = 1; ind < 6; ind++) {
                                        if (document.getElementById("kind" + ind) !== null) {
                                            if (document.getElementById("trfig" + ind).style.display === "") {
                                                var kind = document.getElementById("kind" + ind).value.trim();
                                                var figs = document.getElementById("figs" + ind).value.trim();
                                                var quantity = document.getElementById("quantity" + ind).value.trim();
                                                link = link + "kind" + ind + "=" + kind + "&figs" + ind + "=" + figs + "&quantity" + ind + "=" + quantity + "&";
                                            }
                                        }
                                    }
                                    var exit = false;
                                    $.ajax({
                                        async: false,
                                        type: "POST",
                                        url: link,
                                        success: function (data) {
                                            if (data === "") {
                                                exit = true;
                                            } else {
                                                var arrayJson = JSON.parse(data);

                                                var msg = "";
                                                for (var e = 0; e < arrayJson.length; e++) {
                                                    msg = msg + arrayJson[e] + "<p class='ab'></p>";
                                                }
                                                document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                document.getElementById('errorlarge').style.display = "block";
                                                document.getElementById('errorlargetext').innerHTML = msg;
                                            }
                                        }
                                    });
                                    return exit;
                                }



                                function eseguiricercaclientestraniero() {
                                    var oldclient = '0';
                                    var co1 = document.getElementById('heavy_surname').value.trim();
                                    var na1 = document.getElementById('heavy_name').value.trim();
                                    var nz1 = document.getElementById('heavy_pob_country').value.trim();
                                    var dn1 = document.getElementById('heavy_pob_date').value.trim();
                                    if (co1 !== "" && na1 !== "" && nz1 !== "" && nz1 !== "---" && dn1 !== "") {
                                        document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                        document.getElementById('infolarge').style.display = "block";
                                        document.getElementById('infolargetext').innerHTML = "<i class='fa fa-spin fa-spinner'></i> PLEASE WAITING... SEARCHING CLIENT...";
                                        $.ajax({
                                            async: false,
                                            type: "POST",
                                            url: "Query?type=verificaclientstraniero&ti=B&co1=" + co1 + "&na1=" + na1 + "&nz1=" + nz1 + "&dn1=" + dn1,
                                            success: function (data) {
                                                if (data !== "") {
                                                    var arrayJson = JSON.parse(data);
                                                    var esito = arrayJson[0];
                                                    if (esito === "OK") {
                                                        $('#heavy_sex').val(arrayJson[1]).trigger('change');
                                                        $('#heavy_country').val(arrayJson[2]).trigger('change');
                                                        document.getElementById('heavy_city_dis').value = arrayJson[3];
                                                        $('#heavy_pepI').val(arrayJson[4]).trigger('change');

                                                        document.getElementById('heavy_address').value = arrayJson[5];
                                                        document.getElementById('heavy_zipcode').value = arrayJson[6];
                                                        document.getElementById('heavy_pob_city').value = arrayJson[7];
                                                        if (arrayJson[8] !== "-") {
                                                            $('#heavy_pob_district').val(arrayJson[8]).trigger('change');
                                                        }
                                                        var o = $("<option/>", {value: arrayJson[9], text: document.getElementById('DE_' + arrayJson[9]).value});
                                                        $('#heavy_identcard').append(o);
                                                        $('#heavy_identcard').val(arrayJson[9]).trigger('change');
                                                        $("#heavy_issuedateidentcard").removeAttr('readonly');
                                                        document.getElementById('heavy_numberidentcard').value = arrayJson[10];
                                                        $('#heavy_issuedateidentcard').datepicker().datepicker('setDate', arrayJson[11]);
                                                        $('#heavy_exdateidentcard').datepicker().datepicker('setDate', arrayJson[12]);
                                                        document.getElementById('heavy_issuedbyidentcard').value = arrayJson[13];
                                                        document.getElementById('heavy_issuedplaceidentcard').value = arrayJson[14];
                                                        document.getElementById('heavy_email').value = arrayJson[15];
                                                        document.getElementById('heavy_phonenu').value = arrayJson[16];
                                                        if (arrayJson[17] !== "-") {
                                                            for (var x = 1; x < 6; x++) {
                                                                document.getElementById('comperc' + x).value = arrayJson[17];
                                                                formatValueDecimal_1(document.getElementById('comperc' + x), separatorthousand, separatordecimal);
                                                                f_comperc(x);
                                                            }
                                                        }
                                                        oldclient = arrayJson[18];
                                                        if (arrayJson[19] !== "") {
                                                            document.getElementById('loya').value = arrayJson[19];
                                                        }


                                                        if (arrayJson[20] !== "") {
                                                            $('#heavy_cz_country').val(arrayJson[20]).trigger('change');
                                                        }
                                                        if (arrayJson[21] !== "") {
                                                            $('#heavy_cz_issuingcountry').val(arrayJson[21]).trigger('change');
                                                        }
                                                        if (arrayJson[22] !== "") {
                                                            $('#heavy_sanctions').val(arrayJson[22]).trigger('change');
                                                        }
                                                        if (arrayJson[23] !== "") {
                                                            $('#heavy_pep').val(arrayJson[23]).trigger('change');
                                                        }
                                                        if (arrayJson[24] !== "") {
                                                            document.getElementById('heavy_transactionre').value = arrayJson[24];
                                                        }
                                                        if (arrayJson[25] !== "") {
                                                            document.getElementById('heavy_moneysource').value = arrayJson[25];
                                                        }
                                                        if (arrayJson[26] !== "") {
                                                            document.getElementById('heavy_occupation').value = arrayJson[26];
                                                        }

                                                        if (arrayJson[27] !== "") {
                                                            document.getElementById('pep_position').value = arrayJson[27];
                                                        }

                                                        if (arrayJson[28] !== "") {
                                                            $('#pep_country').val(arrayJson[28]).trigger('change');
                                                        }



                                                        document.getElementById('dataverified').style.display = '';
                                                        document.getElementById('infolargetext').innerHTML = "<i class='fa fa-check font-green-jungle'></i> The customer has been recognized. Please confirm the data.";
                                                    } else {
                                                        document.getElementById('infolargetext').innerHTML = "<i class='fa fa-times font-red'></i> There are no customers found for the entered data.";
                                                    }
                                                }
                                                document.getElementById('oldclient').value = oldclient;
                                            }
                                        });
                                        verifica_1558();
                                    } else {
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "Unable to search, missing fields. Try again.";
                                    }
                                }

                                function ricercaclientestraniero(straniero) {
                                    if (document.getElementById('customerKind').value === "001"
                                            ||
                                            document.getElementById('customerKind').value === "009"
                                            ||
                                            '<%=Constant.is_IT%>' === 'false') {
                                        straniero = true;
                                    } else {
                                        straniero = false;
                                    }

                                    var x = document.getElementsByClassName("fgsearch");
                                    if (straniero) {
                                        if (x.length > 0) {
                                            if (!x[0].className.includes('error')) {
                                                x[0].className = "fgsearch has-warning";
                                                x[1].className = "fgsearch has-warning";
                                                x[2].className = "fgsearch has-warning";
                                                x[3].className = "fgsearch has-warning";
                                            }
                                            var co1 = document.getElementById('heavy_surname').value.trim();
                                            var na1 = document.getElementById('heavy_name').value.trim();
                                            var nz1 = document.getElementById('heavy_pob_country').value.trim();
                                            var dn1 = document.getElementById('heavy_pob_date').value.trim();

                                            if (co1 !== "" && na1 !== "" && nz1 !== "" && nz1 !== "---" && dn1 !== "") {
                                                document.getElementById('verforeign').disabled = false;
                                            } else {
                                                document.getElementById('verforeign').disabled = true;
                                            }
                                        } else {
                                            document.getElementById('verforeign').disabled = true;
                                        }
                                    } else {
                                        if (x.length > 0) {
                                            x[0].className = "fgsearch";
                                            x[1].className = "fgsearch";
                                            x[2].className = "fgsearch";
                                            x[3].className = "fgsearch";
                                            document.getElementById('verforeign').disabled = true;
                                        }
                                    }

                                }

                                function verLOY() {
                                    var loya = document.getElementById("loya").value.trim();
                                    var es = "-1";
                                    if (loya.length === 8) {
                                        $.ajax({
                                            async: false,
                                            type: "POST",
                                            url: "Query?type=queryloy&q=" + loya,
                                            success: function (data) {
                                                if (data !== "") {
                                                    var arrayJson = JSON.parse(data);
                                                    if (arrayJson.length > 1) {
                                                        unlockheavy();
                                                        es = "0";
                                                        document.getElementById('dataverified').style.display = '';
                                                        document.getElementById('heavy_surname').value = arrayJson[0];
                                                        document.getElementById('heavy_name').value = arrayJson[1];
                                                        $('#heavy_country').val(arrayJson[2]).trigger('change');
                                                        if (arrayJson[18] !== "-") {
                                                            var o = $("<option/>", {value: arrayJson[3], text: arrayJson[23]});
                                                            $('#heavy_city').append(o);
                                                            $('#heavy_city').val($('#heavy_city option:first-child').val()).trigger('change');
                                                            document.getElementById('heavy_city_dis').value = arrayJson[3];
                                                        }

                                                        document.getElementById('heavy_address').value = arrayJson[4];
                                                        document.getElementById('heavy_zipcode').value = arrayJson[5];

                                                        if (arrayJson[19] !== "-") {
                                                            var o = $("<option/>", {value: arrayJson[6], text: arrayJson[24]});
                                                            $('#heavy_district').append(o);
                                                            $('#heavy_district').val($('#heavy_district option:first-child').val()).trigger('change');
                                                            document.getElementById('heavy_district_dis').value = arrayJson[24];
                                                        }
                                                        var o = $("<option/>", {value: arrayJson[7], text: document.getElementById('DE_' + arrayJson[7]).value});
                                                        $('#heavy_identcard').append(o);
                                                        $('#heavy_identcard').val(arrayJson[7]).trigger('change');
                                                        $('#heavy_pepI').val(arrayJson[18]).trigger('change');

                                                        $("#heavy_issuedateidentcard").removeAttr('readonly');
                                                        document.getElementById('heavy_numberidentcard').value = arrayJson[8];

                                                        $('#heavy_issuedateidentcard').datepicker().datepicker('setDate', arrayJson[9]);
                                                        $('#heavy_exdateidentcard').datepicker().datepicker('setDate', arrayJson[10]);
                                                        document.getElementById('heavy_issuedbyidentcard').value = arrayJson[11];
                                                        document.getElementById('heavy_issuedplaceidentcard').value = arrayJson[12];
                                                        document.getElementById('heavy_email').value = arrayJson[13];
                                                        document.getElementById('heavy_phonenu').value = arrayJson[14];

                                                        document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                                        document.getElementById('infolarge').style.display = "block";
                                                        document.getElementById('infolargetext').innerHTML = 'The customer has been recognized. Please confirm the data.';
                                                        document.getElementById('oldclient').value = arrayJson[15];
                                                        document.getElementById('heavy_codfisc').value = arrayJson[16];

                                                        $('#heavy_sex').val(arrayJson[17]).trigger('change');

                                                        document.getElementById('heavy_pob_city').value = arrayJson[19];
                                                        document.getElementById('heavy_pob_city').readOnly = true;
                                                        $('#heavy_pob_country').val(arrayJson[21]).trigger('change');
                                                        disable_sel2('heavy_pob_country', 'form1');
                                                        if (arrayJson[20] !== "-") {

                                                            if (arrayJson[20] === "---") {
                                                                $('#heavy_pob_district').val("EE").change();
                                                            } else {
                                                                $('#heavy_pob_district').val(arrayJson[20]).change();
                                                            }
                                                            disable_sel2('heavy_pob_district', 'form1');
                                                            document.getElementById('heavy_pob_district_STR').value = arrayJson[20];
                                                            document.getElementById('heavy_pob_district_STR').readOnly = true;
                                                        }
                                                        document.getElementById('heavy_pob_date').value = arrayJson[22];
                                                        document.getElementById('heavy_pob_date').readOnly = true;

                                                    } else {
                                                        es = arrayJson[0];
                                                    }
                                                }
                                            }
                                        });

                                        $("#welc").prop("disabled", false);
                                        $("#welc").removeAttr('disabled');
                                        verifica_wk();
                                        document.getElementById('oldloy').value = '1';
                                        if (es !== "0") {
                                            $("#fidel").prop("disabled", false);
                                            $("#fidel").removeAttr('disabled');
                                            verifica_ti();
                                            document.getElementById('oldloy').value = '0';
                                            document.getElementById('infolarge').className = document.getElementById('errorlarge').className + " in";
                                            document.getElementById('infolarge').style.display = "block";
                                            document.getElementById('infolargetext').innerHTML = es;
                                            return false;
                                        }

                                        verifica_1558();
                                    } else {
                                        document.getElementById('oldloy').value = '0';
                                        $("#welc").prop("disabled", true);
                                        $("#fidel").prop("disabled", true);
                                        $("#welc").attr('disabled', 'disabled');
                                        $("#fidel").attr('disabled', 'disabled');
                                        document.getElementById('ex9').style.display = 'none';
                                        document.getElementById('ex10').style.display = 'none';
                                        document.getElementById('infolarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('infolarge').style.display = "block";
                                        document.getElementById('infolargetext').innerHTML = "Loyalty Code invalid.";
                                        return false;
                                    }
                                }

                                function resetfield(id) {
                                    if (document.getElementById(id) !== null) {
                                        if (document.getElementById(id).tagName === "INPUT") {
                                            document.getElementById(id).value = "";
                                        } else if (document.getElementById(id).tagName === "SELECT") {
                                            var o = $("<option/>", {value: " ", text: " "});
                                            $('#' + id).append(o);
                                            $('#' + id).val(" ").trigger('change');
                                        }
                                    }
                                }

                                function setfield(id, value) {
                                    if (value === undefined || value === null || value.trim() === "" || value.trim() === "-" || value.trim() === "...") {
                                    } else {
                                        if (document.getElementById(id) !== null) {
                                            if (document.getElementById(id).tagName === "INPUT") {
                                                document.getElementById(id).value = value;
                                            } else if (document.getElementById(id).tagName === "SELECT") {
                                                $('#' + id).val(value).trigger('change');
                                            }
                                        }
                                    }
                                }
                                function setfieldDP(id, value) {
                                    if (value === undefined || value === null || value.trim() === "" || value.trim() === "-" || value.trim() === "...") {
                                    } else {
                                        if (document.getElementById(id) !== null) {
                                            $('#' + id).datepicker().datepicker('setDate', value);
                                        }
                                    }
                                }

                                function load_doclist() {

                                    $("#heavy_identcard").select2({
                                        ajax: {
                                            url: 'Query?type=doc_list_select',
                                            dataType: 'json',
                                            data: function () {
                                                return {
                                                    customerKind: $("#customerKind").val(), // search term
                                                    payout1: $("#total0").val(), // search term
                                                    heavy_country: $("#heavy_country").val()
                                                };
                                            },
                                            processResults: function (data, params) {
                                                params.page = params.page || 1;
                                                return {
                                                    results: data.items,
                                                    pagination: {
                                                        more: (params.page * 30) < data.total_count
                                                    }
                                                };
                                            },
                                            cache: true
                                        },
                                        escapeMarkup: function (markup) {
                                            return markup; // let our custom formatter work
                                        },
                                        minimumInputLength: 0,
                                        templateResult: function (repo) {
                                            if (repo.loading)
                                                return repo.text;
                                            return repo.full_name;
                                        },
                                        templateSelection: function (repo) {
                                            return repo.full_name || repo.text;
                                        }
                                    });
                                }

                                function scandoc1() {
                                    var numsc = parseInt(document.getElementById("numscans").value) + 1;
                                    document.getElementById("numscans").value = numsc;
                                    var obj = {};
                                    obj.Command = "SCAN";
                                    //obj.Command = "DEMO";
                                    obj.CallbackUrl = "<%=linkfisso_scanner%>";
                                    obj.Counter = numsc;
                                    obj.Token = "<%=Token%>";
                                    //obj.Token = "1234567890AAA";
                                    obj.trid = "<%=cod%>";
                                    obj.ipad = document.getElementById("ipaddress").value;
                                    $.post("http://localhost:9000/scan",
                                            JSON.stringify(obj),
                                            function (data, status) {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "Scan?type=scanner",
                                                    contentType: "application/json; charset=utf-8",
                                                    dataType: "json",
                                                    data: JSON.stringify(data),
                                                    success: function (data) {
                                                        document.getElementById('closescanwaiting').click();
                                                        jQuery(data).each(function (i, item) {
                                                            if (item.Success === "true") {
                                                                setfield("heavy_pob_country", item.heavy_pob_country);
                                                                setfield("heavy_numberidentcard", item.heavy_numberidentcard);
                                                                setfield("heavy_surname", item.heavy_surname);
                                                                setfield("heavy_name", item.heavy_name);
                                                                setfield("heavy_address", item.heavy_address);
                                                                setfield("heavy_zipcode", item.heavy_zipcode);
                                                                setfield("heavy_pob_city", item.heavy_pob_city);
                                                                setfield("heavy_identcard", item.heavy_identcard);
                                                                setfield("heavy_sex", item.heavy_sex);
                                                                setfield("heavy_pob_district_STR", item.heavy_pob_district_STR);
                                                                setfield("heavy_issuedplaceidentcard", item.heavy_issuedplaceidentcard);
                                                                setfield("heavy_issuedbyidentcard", item.heavy_issuedbyidentcard);
                                                                setfield("heavy_city_dis", item.heavy_city_dis);
                                                                setfield("heavy_district_dis", item.heavy_district_dis);

                                                                setfieldDP("heavy_issuedateidentcard", item.heavy_issuedateidentcard);
                                                                setfieldDP("heavy_pob_date", item.heavy_pob_date);
                                                                setfieldDP("heavy_exdateidentcard", item.heavy_exdateidentcard);

                                                                document.getElementById('closescanwaiting').click();
                                                                document.getElementById('divscan1').style.display = "none";
                                                                document.getElementById('divscan2').style.display = "";
                                                                $("#btscdoc").removeClass("dark");
                                                                $("#btscdoc").addClass("green-jungle");
                                                                $('#btscdoc').attr("data-original-title", "View scanned document");
                                                                verificaclient();
                                                            } else {
                                                                document.getElementById('closescanwaiting').click();
                                                                document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                                document.getElementById('errorlarge').style.display = "block";
                                                                document.getElementById('errorlargetext').innerHTML = "ERROR DURING SCAN. " + item.Error;
                                                                $("#btscdoc").addClass("dark");
                                                                $("#btscdoc").removeClass("green-jungle");
                                                                $('#btscdoc').attr("data-original-title", "Scan document");
                                                            }
                                                        });
                                                    }
                                                });
                                            }).error(function (jqXHR, textStatus, errorThrown) {
                                        document.getElementById('closescanwaiting').click();
                                        document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                        document.getElementById('errorlarge').style.display = "block";
                                        document.getElementById('errorlargetext').innerHTML = "ERROR DURING SCAN. APPLICATION ERROR, CONNECTION REFUSED.";
                                        $("#btscdoc").addClass("dark");
                                        $("#btscdoc").removeClass("green-jungle");
                                        $('#btscdoc').attr("data-original-title", "Scan document");
                                    });
                                }

                                function viewdocscanned() {
                                    var url = 'Download?type=view_doc_tr&cod=<%=Token%>';
                                    var win = window.open(url, '_blank');
                                    win.focus();
                                }

                                function scandoc2() {
                                    document.getElementById("numscans").value = "0";
                                    $.ajax({
                                        async: false,
                                        type: "POST",
                                        url: 'Scan?type=removescannerdocument&codtr_del=<%=cod%>&coddoc_del=<%=Token%>',
                                        success: function (data) {
                                            resetfield("heavy_pob_country");
                                            resetfield("heavy_numberidentcard");
                                            resetfield("heavy_surname");
                                            resetfield("heavy_name");
                                            resetfield("heavy_address");
                                            resetfield("heavy_zipcode");
                                            resetfield("heavy_pob_city");
                                            resetfield("heavy_identcard");
                                            resetfield("heavy_sex");
                                            resetfield("heavy_pob_district");
                                            resetfield("heavy_pob_district_STR");
                                            resetfield("heavy_issuedplaceidentcard");
                                            resetfield("heavy_issuedateidentcard");
                                            resetfield("heavy_issuedbyidentcard");
                                            resetfield("heavy_city_dis");
                                            resetfield("heavy_district_dis");
                                            resetfield("heavy_pob_date");
                                            resetfield("heavy_exdateidentcard");
                                            $("#btscdoc").addClass("dark");
                                            $("#btscdoc").removeClass("green-jungle");
                                            $('#btscdoc').attr("data-original-title", "Scan document");
                                            document.getElementById('divscan1').style.display = "";
                                            document.getElementById('divscan2').style.display = "none";
                                        }
                                    });
                                }

                                function opsosYES() {
                                    document.getElementById('showanag').style.display = "";
                                    dismiss('czinfo');
                                }

                                function opsosNO() {
                                    document.getElementById('showanag').style.display = "none";
                                    $("#op_sos").prop('checked', false);
                                    dismiss('czinfo');
                                }

                                function opsos() {
                                    var isChecked = $('#op_sos:checked').val() ? true : false;
                                    if (isChecked) {
                                        document.getElementById('czinfobutton').click();
                                    } else {
                                        document.getElementById('showanag').style.display = "none";
                                    }
                                }

                                function cz_pep() {
                                    var pepcz = $("#heavy_pep").val();
                                    if (pepcz === "NO") {
                                        document.getElementById('pepcz').style.display = 'none';
                                    } else {
                                        document.getElementById('pepcz').style.display = '';
                                    }
                                }

                                function sanctions() {
                                    if ('<%=Constant.is_IT%>' === 'false') {
                                        var heavy_sanctions = $("#heavy_sanctions").val();
                                        if (heavy_sanctions === "YES") {
                                            $('#form1').attr('action', 'Operazioni_test?type=ch_tr_deletedENG');
                                        }
                                    }
                                }



                                function controv_opposto(num, den) {
                                    if ('<%=operator%>' === '/') {
                                        return num * den;
                                    } else {
                                        return num / den;
                                    }
                                }

                                function controv(num, den) {
                                    if ('<%=operator%>' === '/') {
                                        return num / den;
                                    } else {
                                        return num * den;
                                    }
                                }

        </script>
    </head>
    <!-- END HEAD -->

    <%if (array_till_open.isEmpty() || iscentral) { %>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white">
        <%} else {%>
    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white" onload="return loadpage();">
        <%}%>
        <!--- MODAL PASSWORD --->
        <div class="modal fade" id="largelogin_hid" tabindex="-1" role="dialog" aria-hidden="true">
            <button type="button" class="btn btn-info btn-lg" id="largelogin_butt" data-toggle="modal" data-target="#largelogin">Open Modal</button>
        </div>
        <div class="modal fade" id="largelogin" tabindex="-1" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Password request</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="col-md-10" style="text-align: left;">
                                        <div class="input-icon">
                                            <i class="fa fa-key font-blue"></i>
                                            <input class="form-control" type="password" autocomplete="off" maxlength="10" placeholder="Password" name="passwordlargelogin" id="passwordlargelogin" onkeypress="checkkeysub('buttonsubmitlargelogin', event);"> 
                                        </div>
                                    </div>
                                    <div class="col-md-2" style="text-align: right;">
                                        <button id="buttonsubmitlargelogin" 
                                                type="submit" class="btn btn-outline blue" 
                                                onclick="return checkvaluepass('passwordlargelogin', '<%=pswx%>', 'largelogin', 'errorlargelogin');">
                                            <i class="fa fa-arrow-right"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-10">
                                    <div class="alert alert-danger" id="errorlargelogin" style="display: none; text-align: left;">
                                        Error. The password is wrong.
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <a class="btn btn-outline btn-icon-only red tooltips" title="Return Homepage" data-placement="bottom" href="index.jsp"><i class="fa fa-home"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- MODAL UNLOCK 
        <div class="modal fade" id="largelock" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Insert unlock code</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="input-icon">    
                                <i class="fa fa-key font-blue"></i>
                                <input class="form-control" autocomplete="off" placeholder="Code" id="unlockCode" name="unlockCode" /> 
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline blue" data-dismiss="modal" 
                                onclick="return verificaSblocco('largelock');"><i class="fa fa-arrow-right"></i> Continue</button>
                        <a type="button" class="btn btn-outline red" data-dismiss="modal" onclick="return dismiss('largelock');"><i class="fa fa-remove"></i> Cancel</a>
                    </div>
                </div>
            </div>
        </div>-->
        <!-- MODAL READ DOC -->
        <div class="modal fade" id="largereaddoc" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Read Document</h4>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" rows="10" placeholder="Click HERE before reading" name="documentReading" id="documentReading"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline red-haze" 
                                onclick="document.getElementById('documentReading').value = '';
                                        document.getElementById('documentReading').focus();"><i class="fa fa-refresh"></i> Clear Text</button>
                        <button type="button" class="btn btn-outline blue" data-dismiss="modal" 
                                onclick="return readDoc('largereaddoc');"><i class="fa fa-arrow-right"></i> Continue</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade" id="largereaddoc" role="dialog" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Read Document</h4>
                    </div>
                    <div class="modal-body">
                        <textarea class="form-control" rows="10" placeholder="Click HERE before reading" name="documentReading" id="documentReading"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline red-haze" 
                                onclick="document.getElementById('documentReading').value = '';
                                        document.getElementById('documentReading').focus();"><i class="fa fa-refresh"></i> Clear Text</button>
                        <button type="button" class="btn btn-outline blue" data-dismiss="modal" 
                                onclick="return readDoc('largereaddoc');"><i class="fa fa-arrow-right"></i> Continue</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="scandoc1" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Scan Document</h4>
                    </div>
                    <div class="modal-body">
                        <div id="divscan1">
                            <a data-toggle="modal" href="#myModal2"
                               class="btn blue btn-outline btn-block" 
                               onclick="return scandoc1();">
                                <i class="fa fa-image"></i> START SCAN</a>
                        </div>
                        <input type="hidden" id="numscans" value="0" />
                        <div id="divscan2" style="display: none;">
                            <a data-toggle="modal" href="#myModal2"
                               class="btn blue btn-outline" 
                               onclick="return scandoc1();" >
                                <i class="fa fa-file-pdf-o"></i> CONTINUE SCAN</a>

                            <button type="button" class="btn green-jungle btn-outline" 
                                    onclick="return viewdocscanned();"><i class="fa fa-file-pdf-o"></i> VIEW PDF</button>

                            <a class="btn red btn-outline" onclick="return scandoc2();">
                                <i class="fa fa-remove"></i> RESET SCAN</a>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn dark btn-outline" 
                                onclick="return dismiss('scandoc1');" data-dismiss="modal"><i class="fa fa-remove"></i> CLOSE</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal2" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">SCAN IN PROGRESS</h4>
                    </div>
                    <div class="modal-body">
                        <h4 class="uppercase"><i class="fa fa-hourglass-half fa-spinner fa-spin"></i> WAITING... Do not close this window.</h4>
                    </div>
                    <div class="modal-footer" style="display: none;">
                        <button type="button" class="btn dark btn-outline" id="closescanwaiting" 
                                onclick="return dismiss('myModal2');" data-dismiss="modal"><i class="fa fa-remove"></i> CLOSE</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal3" role="dialog" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title font-red"><i class="fa fa-remove"></i> DELETE IN PROGRESS</h4>
                    </div>
                    <div class="modal-body">
                        <h4 class="uppercase"><i class="fa fa-hourglass-half fa-spinner fa-spin"></i> WAITING... Do not close this window.</h4>
                    </div>
                    <div class="modal-footer" style="display: none;">
                        <button type="button" class="btn dark btn-outline" id="closescandelete" 
                                onclick="return dismiss('myModal3');" data-dismiss="modal"><i class="fa fa-remove"></i> CLOSE</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- INFO MODAL info transaction -->
        <div class="modal fade" id="infotra" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-full">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title font-blue-dark uppercase"><b>LIST OF TRANSACTION</b></h4>
                        <h6 class="modal-title font-blue-dark uppercase">The customer has been recognized. Please confirm the data.</h6>
                    </div>
                    <div class="modal-body col-md-12" id="infotratext">

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn dark btn-outline" onclick="return dismiss('infotra');" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- ERROR MODAL -->
        <div class="modal fade" id="errorlarge" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">

                        <h4 class="modal-title font-red uppercase"><b>Error message</b></h4>
                    </div>
                    <div class="modal-body" id="errorlargetext">ERROR</div>
                    <div class="modal-footer">
                        <button type="button" class="btn dark btn-outline" onclick="return dismiss('errorlarge');" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- INFO MODAL -->
        <div class="modal fade" id="infolarge" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title font-blue-dark uppercase"><b>Information message</b></h4>
                    </div>
                    <div class="modal-body" id="infolargetext">INFO</div>
                    <div class="modal-footer">
                        <button type="button" class="btn dark btn-outline" onclick="return dismiss('infolarge');" data-dismiss="modal">Close</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <!-- CZ MODAL ABILITA ANGRAFICA -->
        <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
            <button id="czinfobutton" type="button" data-toggle="modal" data-target="#czinfo">Open Modal</button>
        </div>
        <div class="modal fade" id="czinfo" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title font-blue-dark uppercase"><b>Information message</b></h4>
                    </div>
                    <div class="modal-body uppercase">
                        is this operation suspicious?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn green-jungle btn-outline" 
                                onclick="return opsosYES();" data-dismiss="modal">YES</button>
                        <button type="button" class="btn red btn-outline" 
                                onclick="return opsosNO();" data-dismiss="modal">NO</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>

        <!-- BEGIN HEADER -->
        <%@ include file="menu/header1.jsp"%>
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN MENU -->
            <%@ include file="menu/menu_tr4.jsp"%>
            <!-- END MENU -->
            <%
                String lan_index = (String) session.getAttribute("language");
                lan_index = "IT";
                Etichette et_index = new Etichette(lan_index);
            %>
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <!-- VUOTO RAF -->
                    <!-- END THEME PANEL -->
                    <!-- BEGIN PAGE BAR -->
                    <%@ include file="menu/shortcuts.jsp"%>
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <div class="row">
                        <div class="col-md-11">
                            <h3 class="page-title">Transaction <small><b>BUY</b></small></h3>
                        </div>
                        <div class="col-md-1" style="text-align: right;">
                            <img src="assets/soop/img/logocl.png" alt="" class="img-responsive" style="text-align: right;"/> 
                            <input type="text" id="test1" name="test1" style="display: none; width: 1px;"/>

                        </div>
                    </div>

                    <%if (!iscentral) {%>



                    <%if (array_till_open.isEmpty()) { %>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="alert alert-danger">
                                <strong>Warning <i class="fa fa-exclamation-triangle"></i></strong> The operation could not be completed. No till opened. 
                            </div>
                        </div>
                    </div>     


                    <%} else {%>
                    <!-- END PAGE TITLE-->
                    <!-- END PAGE HEADER-->
                    <%
                        String first = "buy";
                        String first_label = StringUtils.capitalize(first);
                    %>
                    <!--<form action="Operazioni?type=ch_tr_buy" method="post" name="form1" id="form1" onsubmit="return subform();" enctype="multipart/form-data">-->
                    <form action="Operazioni_test?type=ch_tr_buy" method="post" name="form1" id="form1" onsubmit="return subform();">
                        <input type="hidden" id="cod" name="cod" value="<%=cod%>"/>
                        <div class="row">
                            <!-- BUY -->
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Type</label>
                                    <div class="input-icon">
                                        <i class="fa fa-check font-blue"></i>
                                        <input type="text" class="form-control uppercase" name="tipotr" readonly="readonly" value="<%=first_label%>"
                                               onkeypress="return keysub(this, event);"> 
                                    </div>
                                </div>
                            </div>
                            <!-- ID OPEN -->
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Id open till</label>
                                    <div class="input-icon">
                                        <i class="fa fa-bookmark font-blue"></i>
                                        <input type="text" class="form-control uppercase" id="idopentill" readonly="readonly" onkeypress="return keysub(this, event);">
                                        <input type="hidden"  id="idopentillv" name="id_open_till">

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>&nbsp;</label><p class='ab'></p>
                                    <button type="button" class="btn btn-outline red-haze tooltips" title="Clear page" 
                                            data-placement="top" onclick="return window.location.reload(true);">
                                        <i class="fa fa-refresh"></i></button>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                            <!-- till -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Till</label><p class='ab'></p>
                                    <select class="form-control select2" name="till" id="till" onchange="return changetill();" onkeypress="return keysub(this, event);">
                                    </select>
                                </div>
                            </div>
                            <!-- open till -->
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>&nbsp;</label><p class='ab'></p>
                                    <a target="_blank" href="ti_openclose.jsp" class="btn btn-outline dark tooltips" title="Open/Close cash and till" data-placement="top"><i class="fa fa-calculator"></i></a>
                                    <a href="transaction_searchcurr.jsp" class="btn btn-outline dark tooltips fancyBoxRaf" 
                                       title="Search Currency" data-placement="top"><i class="fa fa-search"></i>
                                    </a>

                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label><i class="fa fa-key font-blue"></i> UNLOCK RATE </label> 
                                    <i class="fa fa-info-circle tooltips font-blue" title="Select one option for unlock rate" data-placement="top"></i>
                                    <!--<button type="button" class="btn btn-outline dark tooltips" 
                                            title="Unlock Rate" data-placement="top" 
                                            onclick="return verificaSblocco_new();">
                                        <i class="fa fa-key"></i></button>-->
                                    <select class="form-control select2" 
                                            name="unlockratesel" id="unlockratesel" 
                                            onchange="return verificaSblocco_new(this);"
                                            onkeypress="return keysub(this, event);" 
                                            placeholder="None">
                                        <option value="">None</option>
                                        <% for (int i = 0; i < array_unlockrate.size(); i++) {
                                                if (array_unlockrate.get(i)[2].equals("0")) {
                                        %>
                                        <option value="<%=array_unlockrate.get(i)[0]%>"><%=array_unlockrate.get(i)[1]%></option>
                                        <%}
                                            }%>
                                    </select>  

                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <!-- customer kind -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Customer Kind <span class="font-red">*</span></label>
                                    <select class="form-control select2" name="tipocliente" id="customerKind"
                                            onchange="return changecustomerKind();"
                                            onkeypress="return keysub(this, event);">
                                        <option value="None">None</option>

                                        <%for (int i = 0; i < array_custkind.size(); i++) {

                                                if (array_custkind.get(i).getFg_tipo_cliente().equals("20")) {
                                                    if (ln.isCompanyenabled()) {%>
                                        <option value="<%=array_custkind.get(i).getTipologia_clienti()%>"><%=array_custkind.get(i).getDe_tipologia_clienti()%></option>
                                        <%}
                                        } else {%>
                                        <option value="<%=array_custkind.get(i).getTipologia_clienti()%>"><%=array_custkind.get(i).getDe_tipologia_clienti()%></option>
                                        <%}
                                            }%>
                                    </select>
                                </div>
                            </div>
                            <!-- pay out -->
                            <div class="col-md-6">
                                <div class="mt-element-list">
                                    <div class="mt-list-head list-news font-white bg-blue">
                                        <div class="list-head-title-container">
                                            <h3 class="list-title pull-left"><i class="fa <%=Constant.iconcur%>"></i></h3><h3 class="list-title"> Pay Out <b><span class="pull-right" id="payout0">0<%=decimal%>00</span></b></h3>
                                        </div>
                                        <input type="hidden" id="payout1" name="payout1" value="0<%=decimal%>00"/>
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <!-- total -->
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Total</label>
                                    <div class="input-icon">
                                        <i class="fa <%=Constant.iconcur%> font-blue"></i>
                                        <input type="text" class="form-control inputright inputbold" name="total0" id="total0" readonly="readonly" value="0<%=decimal%>00" onkeypress="return keysub(this, event);"> 
                                    </div>
                                </div>
                            </div>
                            <!-- fix -->
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Fix</label>
                                    <div class="input-icon">
                                        <i class="fa <%=Constant.iconcur%> font-blue"></i>
                                        <input type="text" class="form-control inputright inputbold" id="fix0" name="fix0" 
                                               readonly="readonly" value="0<%=decimal%>00" onkeypress="return keysub(this, event);"> 
                                    </div>
                                </div>
                            </div>
                            <!-- com -->
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Com</label>
                                    <div class="input-icon">
                                        <i class="fa <%=Constant.iconcur%> font-blue"></i>
                                        <input type="text" class="form-control inputright inputbold" id="com0" name="com0" 
                                               readonly="readonly" value="0<%=decimal%>00" onkeypress="return keysub(this, event);"> 
                                    </div>
                                </div>
                            </div>
                            <!-- round -->
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Round</label>
                                    <div class="input-icon">
                                        <i class="fa <%=Constant.iconcur%> font-blue"></i>
                                        <input type="text" class="form-control inputright inputbold" id="round0" name="round0" 
                                               readonly="readonly" value="0<%=decimal%>00" onkeypress="return keysub(this, event);"> 
                                    </div>
                                </div>
                            </div>
                            <!-- commission -->
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>Commission</label>
                                    <div class="input-icon">
                                        <i class="fa <%=Constant.iconcur%> font-blue"></i>
                                        <input type="text" class="form-control inputright inputbold" id="commission0" name="commission0" readonly="readonly" value="0<%=decimal%>00" onkeypress="return keysub(this, event);"> 
                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <!-- note -->
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label><i class="fa fa-sticky-note-o font-blue"></i> Note</label>
                                    <input type="text" class="form-control" name="note1" id="note1" 
                                           maxlength="100" onkeypress="return keysub(this, event);" onchange="return fieldNOSPecial_2(this.id);"> 
                                </div>
                            </div>

                            <%if (showagency) {%>
                            <div class="clearfix"></div>
                            <!-- agen -->
                            <div class="col-md-12">
                                <div class="md-checkbox has-info">
                                    <input type="checkbox" id="agroy" name="agroy" class="md-checkbox" onclick="return checkver('agroy', 'aglist');" onkeypress="return keysub(this, event);"> 
                                    <label for="agroy">
                                        <span></span>
                                        <span class="check"></span>
                                        <span class="box"></span> Agency Royalty
                                    </label>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-md-6" id="aglist" style="display: none;">
                                <div class="form-group">
                                    <label>Agency</label>
                                    <select class="form-control select2" name="heavy_agency" id="heavy_agency" onkeypress="return keysub(this, event);">
                                        <%for (int i = 0; i < array_agency.size(); i++) {%>
                                        <option value="<%=array_agency.get(i).getAgenzia()%>"><%=array_agency.get(i).getAgenzia()%> - <%=array_agency.get(i).getDe_agenzia()%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <%}%>
                            <p class='ab'></p>
                            <!-- figurees -->

                            <%if (Constant.tr_1325) {%>

                            <div class="col-md-12">
                                <div class="portlet box blue">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-money"></i>
                                            <span class="caption-subject">Figures</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <input type="hidden" name="index_t1" id="index_t1" value="1"/>
                                                <%if (!Utility.isfirefox(request)) {%>
                                                <table class="table table-responsive table-bordered raftable">
                                                    <%} else {%>
                                                    <table class="table table-responsive table-bordered raftablefirefox">
                                                        <%}%>
                                                        <tbody>
                                                        <thead></thead>
                                                        <%
                                                            for (int i = 1; i < 6; i++) {
                                                                String idrow = "trfig" + i;
                                                                String style = "";
                                                                if (i > 1) {
                                                                    style = "style='display:none;'";
                                                                }
                                                        %>
                                                        <tr id="C<%=idrow%>" <%=style%>>
                                                            <th class="tabnow" style="width:5px;">#</th>
                                                            <th class="tabnow" style="width:10px;">SB</th>
                                                            <th class="tabnow" style="width:50px;">Kind</th>
                                                            <th class="tabnow" style="width:200px;">Figures</th>
                                                            <th class="tabnow" style="width:130px;">Quantity</th>
                                                            <th class="tabnow" style="width:160px;">Rate</th>
                                                            <th class="tabnow" style="width:60px;">% Com.</th>
                                                            <th class="tabnow" style="width:60px;">Fx Com.</th>
                                                        </tr>

                                                        <tr id="<%=idrow%>" <%=style%>>



                                                        <input type="hidden" id="roundvalue<%=i%>" name="roundvalue<%=i%>" value="0.00"/>
                                                        <td class="tabnow" valign="top"><%=i%></td>

                                                        <td>
                                                            <select class="form-control select2" id="sb<%=i%>"  style="width: 100%;"
                                                                    disabled onchange="return enable_sb('<%=i%>');"
                                                                    name="sb<%=i%>" data-container="body"
                                                                    onkeypress="return keysub(this, event);">
                                                                <option value="N">NO</option>
                                                                <%if (!Constant.is_CZ) {%>
                                                                <option value="Y">YES</option>
                                                                <option value="F">FREE</option>
                                                                <%}%>
                                                            </select>
                                                        </td>

                                                        <td class="tabnow">
                                                            <select class="form-control select2" id="kind<%=i%>" style="width: 100%;" name="kind<%=i%>" 
                                                                    data-container="body" 
                                                                    onchange="return changeKind('<%=i%>');" onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>

                                                        <td class="tabnow">
                                                            <select class="form-control select2" id="figs<%=i%>" style="width: 100%;" name="figs<%=i%>" data-container="body"
                                                                    onchange="return changefigs('<%=i%>');" onkeypress="return keysub(this, event);">

                                                            </select>
                                                        </td>
                                                        <td class="tabnow">
                                                            <input type="text"
                                                                   class="form-control inputright" id="quantity<%=i%>" maxlength="11"
                                                                   name="quantity<%=i%>" value="1<%=decimal%>00" 
                                                                   onfocus="this.select();"
                                                                   onfocusout="return changequantity('<%=i%>');"
                                                                   onkeypress="return keysub(this, event);">
                                                        </td>
                                                        <td class="tabnow">
                                                            <div id="divrate<%=i%>">
                                                                <select class="form-control select2" id="rate<%=i%>" name="rate<%=i%>" 
                                                                        data-container="body" style="width: 100%;"
                                                                        onchange="return change_rate2021('<%=i%>')"
                                                                        onkeypress="return keysub(this, event);"></select>
                                                            </div>        
                                                            <input type="text" class="form-control inputright" id="fieldrate<%=i%>" name="fieldrate<%=i%>" 
                                                                   value="0<%=decimal%>00" style="display: none;" 
                                                                   onfocus="this.select();"
                                                                   onkeypress="return keysub(this, event);">

                                                        </td>
                                                        <td class="tabnow">
                                                            <input type="text" class="form-control inputright" 
                                                                   id="comperc<%=i%>" name="comperc<%=i%>" value="0<%=decimal%>00" 
                                                                   onkeypress="return keysub(this, event);"
                                                                   onchange="return f_comperc('<%=i%>');" onfocus="this.select();" 
                                                                   onfocusout="return keysub(this, event);">
                                                        </td>
                                                        <td class="tabnow"><input type="text" class="form-control inputright" id="fxcomm<%=i%>" name="fxcomm<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);"></td>
                                                        </tr>
                                                        <tr id="A<%=idrow%>" <%=style%>>


                                                            <th class="tabnow" style="width:140px;">Net</th>
                                                            <th class="tabnow" style="width:190px;">Kind Fix Com.</th>
                                                            <th class="tabnow" style="width:180px;">Low Com. Justify</th>
                                                            <th class="tabnow" style="width:200px;">BB Fidelity Code</th>
                                                            <th class="tabnow" style="width:50px;">POS</th>
                                                            <th class="tabnow" style="width:100px;">CC Number</th>
                                                            <th class="tabnow" style="width:50px; text-align: left;" colspan="2">Reset</th>

                                                        </tr>

                                                        <tr id="B<%=idrow%>" <%=style%>>


                                                        <input type="hidden" class="form-control inputright" id="totperc<%=i%>" name="totperc<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);">

                                                        <input type="hidden" class="form-control inputright" id="totcomm<%=i%>" name="totcomm<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);">

                                                        <input type="hidden" class="form-control inputright" id="total<%=i%>" name="total<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);">
                                                        <td class="tabnow">
                                                            <input type="text" class="form-control inputright" id="net<%=i%>" 
                                                                   onfocus="this.select();" name="net<%=i%>" value="0<%=decimal%>00" 
                                                                   onfocusout="return changeNet('<%=i%>');" 
                                                                   onkeypress="return keysub(this, event);">
                                                        </td>
                                                        <td class="tabnow">
                                                            <select  style="width: 100%;" class="form-control select2" id="kindfixcomm<%=i%>" name="kindfixcomm<%=i%>"
                                                                     data-container="body" 
                                                                     onchange="return changeFixcomm_kind('<%=i%>');" onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>

                                                        <td class="tabnow">
                                                            <select style="width: 100%;" class="form-control select2" id="lowcommjus<%=i%>" name="lowcommjus<%=i%>" 
                                                                    data-container="body" disabled="disabled" onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>

                                                        <select style="display:none;" class="form-control" 
                                                                id="bb<%=i%>" 
                                                                name="bb<%=i%>"
                                                                onkeypress="return keysub(this, event);" 
                                                                onchange="return enable_bb('<%=i%>');" />

                                                        <td class="tabnow">
                                                            <div class="input-icon right">
                                                                <i class="fa fa-cogs tooltips" title="Check" data-placement="left" 
                                                                   onfocus="this.select();" onclick="return check_fidelity_cod('<%=i%>');"></i>
                                                                <input type="text" class="form-control inputright" 
                                                                       id="fidcode<%=i%>" name="fidcode<%=i%>" value="" 
                                                                       disabled onkeypress="return keysub(this, event);" />
                                                            </div>
                                                        </td>
                                                        <td class="tabnow">
                                                            <select  style="width: 100%;" class="form-control select2" id="posvalue<%=i%>" name="posvalue<%=i%>" 
                                                                     data-container="body" disabled="disabled" onfocus="this.select();" 
                                                                     onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>
                                                        <td class="tabnow">
                                                            <input type="text" onfocus="this.select();"
                                                                   class="form-control inputright" id="posnum<%=i%>" onkeypress="return keysub(this, event);"
                                                                   name="posnum<%=i%>" disabled="disabled"
                                                                   maxlength="4" onkeyup="return fieldOnlyNumber(this.id);"/>
                                                        </td>
                                                        <input type="hidden" id="sb_total<%=i%>" name="sb_total<%=i%>" value="0.00"/>
                                                        <input type="hidden" name="sb_val<%=i%>" id="sb_val<%=i%>" value="0"/>
                                                        <td colspan="2">
                                                            <button type="button" class="btn btn-outline red-haze tooltips" 
                                                                    title="Reset Row" data-container="body" data-placement="top" 
                                                                    onclick="return resetRow('<%=i%>')" id="delrow<%=i%>"><i class="fa fa-trash"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-outline green tooltips" id="enarow<%=i%>" 
                                                                    title="Enable Row" data-container="body" data-placement="top" 
                                                                    onclick="return enableRow('<%=i%>');" style="display: none;">
                                                                <i class="fa fa-check"></i>
                                                            </button>
                                                        </td>

                                                        </tr>
                                                        <tr id="D<%=idrow%>" <%=style%>><td class="separatordt" colspan="8" style="padding: 1px;"></td></tr>
                                                            <%}%>
                                                        </tbody>
                                                    </table>
                                            </div>
                                            <div class="col-md-4">
                                                <%if (!Constant.is_CZ) {%>
                                                <button type="button" class="btn btn-outline blue" onclick="return showRow();"><i class="fa fa-plus"></i> Add Row</button>
                                                <%}%>
                                            </div>
                                            <div class="col-md-4"></div>
                                            <h4 class="col-md-4" style="text-align: right;">Net Total <b id="totalnet">0<%=decimal%>00</b></h4>
                                            <div class="col-md-4"></div><div class="col-md-4"></div>
                                            <h4 class="col-md-4" style="text-align: right;">Total <b id="total00">0<%=decimal%>00</b></h4>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <%} else {%>

                            <div class="col-md-12">
                                <div class="portlet box blue">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-money"></i>
                                            <span class="caption-subject">Figures</span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <input type="hidden" name="index_t1" id="index_t1" value="1"/>
                                                <%if (!Utility.isfirefox(request)) {%>
                                                <table class="table table-responsive table-bordered table-scrollable raftable" id="sample_0">
                                                    <%} else {%>
                                                    <table class="table table-responsive table-bordered table-scrollable raftablefirefox" id="sample_0">
                                                        <%}%>
                                                        <thead>
                                                            <tr>
                                                                <th class="tabnow inputright" style="width:5px;">#</th>
                                                                <th class="tabnow" style="width:10px;">SB</th>
                                                                <th class="tabnow" style="width:120px;">Kind</th>
                                                                <th class="tabnow" style="width:100px;">POS</th>
                                                                <th class="tabnow" style="width:100px;">CC Number</th>
                                                                <th class="tabnow" style="width:200px;">Figures</th>
                                                                <th class="tabnow" style="width:130px;">Quantity</th>
                                                                <th class="tabnow" style="width:160px;">Rate</th>
                                                                <th class="tabnow" style="width:60px;">% Com.</th>
                                                                <th class="tabnow" style="width:80px;">% Tot</th>
                                                                <th class="tabnow" style="width:60px;">Fx Com.</th>
                                                                <th class="tabnow" style="width:120px;">Tot Com.</th>
                                                                <th class="tabnow" style="width:140px;">Net</th>
                                                                    <%if (Constant.newpread) {%>
                                                                <th class="tabnow" style="width:140px;">Spread</th>
                                                                    <%}%>
                                                                <th class="tabnow" style="width:100px;">Total</th>
                                                                <th class="tabnow" style="width:190px;">Kind Fix Com.</th>
                                                                <th class="tabnow" style="width:180px;">Low Com. Justify</th>
                                                                <th class="tabnow" style="width:10px;">BB</th>
                                                                <th class="tabnow" style="width:200px;">BB Fidelity Code</th>


                                                                <th class="tabnow" style="width:50px;">Reset</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <%
                                                                for (int i = 1; i < 6; i++) {
                                                                    String idrow = "trfig" + i;
                                                                    String style = "";
                                                                    if (i > 1) {
                                                                        style = "style='display:none;'";
                                                                    }
                                                            %>
                                                            <tr id="<%=idrow%>" <%=style%>>



                                                        <input type="hidden" id="roundvalue<%=i%>" name="roundvalue<%=i%>" value="0.00"/>
                                                        <td class="tabnow" valign="top"><%=i%></td>

                                                        <td>
                                                            <select class="form-control select2" id="sb<%=i%>" 
                                                                    disabled onchange="return enable_sb('<%=i%>');"
                                                                    name="sb<%=i%>" data-container="body"
                                                                    onkeypress="return keysub(this, event);">
                                                                <option value="N">NO</option>
                                                                <%if (!Constant.is_CZ) {%>
                                                                <option value="Y">YES</option>
                                                                <option value="F">FREE</option>
                                                                <%}%>
                                                            </select>
                                                        </td>

                                                        <td class="tabnow">
                                                            <select class="form-control select2" id="kind<%=i%>" name="kind<%=i%>" 
                                                                    data-container="body" 
                                                                    onchange="return changeKind('<%=i%>');" onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>
                                                        <td class="tabnow">
                                                            <select class="form-control select2" id="posvalue<%=i%>" name="posvalue<%=i%>" 
                                                                    data-container="body" disabled="disabled" onfocus="this.select();" 
                                                                    onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>
                                                        <td class="tabnow">
                                                            <input type="text" onfocus="this.select();"
                                                                   class="form-control inputright" id="posnum<%=i%>" onkeypress="return keysub(this, event);"
                                                                   name="posnum<%=i%>" disabled="disabled"
                                                                   maxlength="4" onkeyup="return fieldOnlyNumber(this.id);"/>
                                                        </td>
                                                        <td class="tabnow">
                                                            <select class="form-control select2" id="figs<%=i%>" name="figs<%=i%>" data-container="body"
                                                                    onchange="return changefigs('<%=i%>');" onkeypress="return keysub(this, event);">

                                                            </select>
                                                        </td>
                                                        <td class="tabnow">
                                                            <input type="text"
                                                                   class="form-control inputright" id="quantity<%=i%>" maxlength="11"
                                                                   name="quantity<%=i%>" value="1<%=decimal%>00" 
                                                                   onfocus="this.select();"
                                                                   onfocusout="return changequantity('<%=i%>');"
                                                                   onkeypress="return keysub(this, event);">
                                                        </td>
                                                        <td class="tabnow">
                                                            <div id="divrate<%=i%>">
                                                                <select class="form-control select2" id="rate<%=i%>" name="rate<%=i%>" data-container="body"
                                                                        onchange="return change_rate2021('<%=i%>')"
                                                                        onkeypress="return keysub(this, event);"></select>
                                                            </div>        
                                                            <input type="text" class="form-control inputright" id="fieldrate<%=i%>" name="fieldrate<%=i%>" 
                                                                   value="0<%=decimal%>00" style="display: none;" 
                                                                   onfocus="this.select();"
                                                                   onkeypress="return keysub(this, event);">

                                                        </td>

                                                        <td class="tabnow">
                                                            <input type="text" class="form-control inputright" 
                                                                   id="comperc<%=i%>" name="comperc<%=i%>" value="0<%=decimal%>00" 
                                                                   onkeypress="return keysub(this, event);"
                                                                   onchange="return f_comperc('<%=i%>');" onfocus="this.select();" 
                                                                   onfocusout="return keysub(this, event);">
                                                        </td>
                                                        <td class="tabnow"><input type="text" class="form-control inputright" id="totperc<%=i%>" name="totperc<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);"></td>
                                                        <td class="tabnow"><input type="text" class="form-control inputright" id="fxcomm<%=i%>" name="fxcomm<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);"></td>
                                                        <td class="tabnow"><input type="text" class="form-control inputright" id="totcomm<%=i%>" name="totcomm<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);"></td>
                                                        <td class="tabnow">
                                                            <input type="text" class="form-control inputright" id="net<%=i%>" 
                                                                   onfocus="this.select();" name="net<%=i%>" value="0<%=decimal%>00" 
                                                                   onfocusout="return changeNet('<%=i%>');" 
                                                                   onkeypress="return keysub(this, event);">
                                                        </td>
                                                        <%if (Constant.newpread) {%>
                                                        <td class="tabnow">
                                                            <input type="text" class="form-control inputright" id="spread<%=i%>" name="spread<%=i%>" value="0<%=decimal%>00" readonly="readonly" onkeypress="return keysub(this, event);">
                                                        </td>
                                                        <%} else {%>
                                                        <input type="hidden" id="spread<%=i%>" name="spread<%=i%>" value="0<%=decimal%>00" />
                                                        <%}%>
                                                        <td class="tabnow"><input type="text" class="form-control inputright" id="total<%=i%>" name="total<%=i%>" readonly="readonly" value="0<%=decimal%>00"onkeypress="return keysub(this, event);"></td>
                                                        <td class="tabnow">
                                                            <select style="width:200px;" class="form-control select2" id="kindfixcomm<%=i%>" name="kindfixcomm<%=i%>"
                                                                    data-container="body" 
                                                                    onchange="return changeFixcomm_kind('<%=i%>');" onkeypress="return keysub(this, event);">
                                                            </select>
                                                        </td>

                                                        <td class="tabnow">
                                                            <select style="width:200px;"class="form-control select2" id="lowcommjus<%=i%>" name="lowcommjus<%=i%>" 
                                                                    data-container="body" disabled="disabled" onkeypress="return keysub(this, event);">
                                                            </select>
                                                        <td> 
                                                            <select class="form-control select2" id="bb<%=i%>" 
                                                                    name="bb<%=i%>" data-container="body" disabled
                                                                    onkeypress="return keysub(this, event);" 
                                                                    onchange="return enable_bb('<%=i%>');" >
                                                                <option value="N">NO</option>
                                                                <%if (!Constant.is_CZ) {%>
                                                                <option value="Y">YES</option>
                                                                <%}%>
                                                            </select>
                                                        </td>
                                                        <td class="tabnow">
                                                            <div class="input-icon right">
                                                                <i class="fa fa-cogs tooltips" title="Check" data-placement="left" 
                                                                   onfocus="this.select();" onclick="return check_fidelity_cod('<%=i%>');"></i>
                                                                <input type="text" class="form-control inputright" 
                                                                       id="fidcode<%=i%>" name="fidcode<%=i%>" value="" 
                                                                       disabled onkeypress="return keysub(this, event);" />
                                                            </div>
                                                        </td>

                                                        <input type="hidden" id="sb_total<%=i%>" name="sb_total<%=i%>" value="0.00"/>
                                                        <input type="hidden" name="sb_val<%=i%>" id="sb_val<%=i%>" value="0"/>
                                                        <td>
                                                            <button type="button" class="btn btn-outline red-haze tooltips" 
                                                                    title="Reset Row" data-container="body" data-placement="top" 
                                                                    onclick="return resetRow('<%=i%>')" id="delrow<%=i%>"><i class="fa fa-trash"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-outline green tooltips" id="enarow<%=i%>" 
                                                                    title="Enable Row" data-container="body" data-placement="top" 
                                                                    onclick="return enableRow('<%=i%>');" style="display: none;">
                                                                <i class="fa fa-check"></i>
                                                            </button>
                                                        </td>
                                                        </tr>
                                                        <%}%>
                                                        </tbody>
                                                    </table>
                                            </div>
                                            <div class="col-md-4">
                                                <%if (!Constant.is_CZ) {%>
                                                <button type="button" class="btn btn-outline blue" onclick="return showRow();"><i class="fa fa-plus"></i> Add Row</button>
                                                <%}%>
                                            </div>
                                            <div class="col-md-4"></div>
                                            <h4 class="col-md-4" style="text-align: right;">Net Total <b id="totalnet">0<%=decimal%>00</b></h4>
                                            <%if (Constant.newpread) {%>
                                            <div class="col-md-4"></div><div class="col-md-4"></div>
                                            <h4 class="col-md-4" style="text-align: right;">Spread Total <b id="totalspread">0<%=decimal%>00</b></h4>
                                            <input type="hidden" name="totalspread" id="totalspreadv" value="0<%=decimal%>00"/>
                                            <%}%>
                                            <div class="col-md-4"></div><div class="col-md-4"></div>
                                            <h4 class="col-md-4" style="text-align: right;">Total <b id="total00">0<%=decimal%>00</b></h4>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%}%>

                            <%
                                String fgsearch = "";
                                if (!Constant.is_CZ) {
                                    fgsearch = "fgsearch";
                                }
                            %>

                            <div class="clearfix"></div>
                            <input type="hidden" name="unlockCode_final" id="unlockCode_final" value="-"/>
                            <input type="hidden" name="typerate" id="typerate" value="NORMAL"/>
                            <input type="hidden" name="oldclient" id="oldclient" value="0"/>
                            <input type="hidden" name="oldloy" id="oldloy" value="0"/>
                            <input type="hidden" name="thranag" id="thranag" value="0"/>
                            <input type="hidden" name="maxweek" id="maxweek" value="0"/>
                            <input type="hidden" name="showmod" id="showmod" value="-1"/>
                            <!-- customer information pf -->

                            <div id="showanag" style="display: none;">

                                <div class="col-md-12" id="custinfo_1">
                                    <div class="portlet box blue">
                                        <div class="portlet-title">
                                            <div class="caption">
                                                <i class="fa fa-user"></i>
                                                <span class="caption-subject">KYC - Know Your Customer</span>
                                            </div>
                                        </div>
                                        <div class="portlet-body">
                                            <%if (Constant.is_IT) {%>
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-credit-card font-blue"></i> Loyalty Code</label>
                                                        <input type="text" class="form-control" id="loya" name="loya" 
                                                               maxlength="8" 
                                                               onkeyup="return modificaLOY(this, event);"
                                                               onkeypress="return keysub(this, event);"/> 

                                                    </div>
                                                </div> 
                                                <div class="col-md-2">
                                                    <label>&nbsp;</label>
                                                    <div class="input-icon">
                                                        <button type="button" class="btn btn-outline dark tooltips" 
                                                                title="Associate / Verify" onclick="return verLOY();">
                                                            <i class="fa fa-chevron-circle-down"></i>
                                                        </button>
                                                    </div> 
                                                </div> 
                                                <%if (false) {%>
                                                <div class="col-md-4">
                                                    <label>&nbsp;</label>
                                                    <div class="md-checkbox">
                                                        <input type="checkbox" id="welc" name="welc" disabled
                                                               class="md-checkbox" 
                                                               onkeypress="return keysub(this, event);"> 
                                                        <label for="welc">
                                                            <span></span>
                                                            <span class="check"></span>
                                                            <span class="box"></span> Welcome Kit
                                                        </label>

                                                    </div>
                                                    <label id="ex9">&nbsp;</label>
                                                </div>
                                                <div class="col-md-4">
                                                    <label>&nbsp;</label>
                                                    <div class="md-checkbox">
                                                        <input type="checkbox" id="fidel" name="fidel" disabled
                                                               class="md-checkbox" onkeypress="return keysub(this, event);"> 
                                                        <label for="fidel">
                                                            <span></span>
                                                            <span class="check"></span>
                                                            <span class="box"></span> Active NEW Top Italy Card
                                                        </label>

                                                    </div>
                                                    <label id="ex10">&nbsp;</label>
                                                </div>
                                                <script type="text/javascript">

                                                    function verifica_wk() {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "Query?type=query_quantity_WK&q=WELCOMEKIT",
                                                            success: function (data) {
                                                                if (data !== "") {
                                                                    var arrayJson = JSON.parse(data);
                                                                    if (arrayJson.length > 0) {
                                                                        document.getElementById('ex9').style.display = '';
                                                                        document.getElementById('ex9').innerHTML = "";
                                                                        for (var i = 0; i < arrayJson.length - 1; i = i + 2) {
                                                                            var span1 = document.createElement('span');
                                                                            span1.className = 'label label-sm label-primary';
                                                                            span1.innerHTML = arrayJson[i] + ' - <b>' + arrayJson[i + 1] + '</b>';
                                                                            var span2 = document.createElement('span');
                                                                            span2.innerHTML = '&nbsp;';
                                                                            document.getElementById('ex9').appendChild(span1);
                                                                            document.getElementById('ex9').appendChild(span2);
                                                                        }
                                                                    } else {
                                                                        document.getElementById('ex9').innerHTML = "";
                                                                        document.getElementById('ex9').style.display = 'none';
                                                                    }
                                                                }
                                                            }
                                                        });
                                                    }
                                                    function verifica_ti() {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "Query?type=query_quantity_WK&q=TOPITACARD",
                                                            success: function (data) {
                                                                if (data !== "") {
                                                                    var arrayJson = JSON.parse(data);
                                                                    if (arrayJson.length > 0) {
                                                                        document.getElementById('ex10').style.display = '';
                                                                        document.getElementById('ex10').innerHTML = "";
                                                                        for (var i = 0; i < arrayJson.length - 1; i = i + 2) {
                                                                            var span1 = document.createElement('span');
                                                                            span1.className = 'label label-sm label-primary';
                                                                            span1.innerHTML = arrayJson[i] + ' - <b>' + arrayJson[i + 1] + '</b>';
                                                                            var span2 = document.createElement('span');
                                                                            span2.innerHTML = '&nbsp;';
                                                                            document.getElementById('ex10').appendChild(span1);
                                                                            document.getElementById('ex10').appendChild(span2);
                                                                        }
                                                                    } else {
                                                                        document.getElementById('ex10').innerHTML = "";
                                                                        document.getElementById('ex10').style.display = 'none';
                                                                    }
                                                                }
                                                            }
                                                        });
                                                    }
                                                </script>
                                                <%}%>
                                            </div>
                                            <hr>
                                            <%}%>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group <%=fgsearch%>" id="newuk_1">
                                                        <label><i class="fa fa-user font-blue"></i> Surname <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_surname" name="heavy_surname" 
                                                               maxlength="30" 
                                                               onchange="return verificanomecogn();" 
                                                               onkeypress="return keysub(this, event);" 
                                                               onkeyup="return modificaOAMSurname(this, event);"/> 
                                                        <!--onkeyup="return fieldNameSurname(this.id);"/> -->
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> Sex <span class='font-red'>*</span></label>
                                                        <select class="form-control select2" name="heavy_sex" id="heavy_sex">
                                                            <option value=""></option>
                                                            <option value="M">Male</option>
                                                            <option value="F">Female</option>
                                                            <%if (!Constant.is_IT) {%>
                                                            <option value="O">Other</option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                </div>

                                                <%
                                                    String disabilitatasti = "disabled";
                                                    if (Constant.is_IT) {
                                                        disabilitatasti = "";
                                                    }%>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label>&nbsp;</label>
                                                        <div class="input-icon">
                                                            <button type="button" class="btn btn-outline dark tooltips" 
                                                                    id="btscdoc" <%=disabilitatasti%>
                                                                    title="Scan Document" 
                                                                    data-toggle="modal" data-target="#scandoc1" >
                                                                <i class="fa fa-image"></i>
                                                            </button>
                                                            <button type="button" <%=disabilitatasti%> class="btn btn-outline dark tooltips" 
                                                                    title="Read Document" data-toggle="modal"data-target="#largereaddoc">
                                                                <i class="fa fa-file"></i>
                                                            </button>
                                                            <button class="btn btn-outline dark tooltips" <%=disabilitatasti%>
                                                                    type="button" title="Check Tax Code" id="buttoncheckcf" 
                                                                    onclick="return checkcodfisc();">
                                                                <i class="fa fa-credit-card"></i>
                                                            </button>
                                                            <button type="button" <%=disabilitatasti%> id="buttoncheckaeg"
                                                                    target="_blank" 
                                                                    onclick="return linkAE();"
                                                                    class="btn btn-outline dark tooltips" 
                                                                    title="Check AE">
                                                                <i class="fa fa-tasks"></i>
                                                            </button>
                                                            <button type="button" id="verforeign"
                                                                    onclick="return eseguiricercaclientestraniero();"
                                                                    class="btn btn-outline dark tooltips" 
                                                                    title="Verify Client <%if (Constant.is_IT) {%>(FOREIGN)<%}%>">
                                                                <i class="fa fa-user-circle"></i>
                                                            </button>
                                                            <%
                                                                if (false) {
                                                                    String token = "ADD" + Utility.generaId(47);
                                                                    String fisso = Utility.createServerReturnADDAddress();
                                                                    String signport = Engine.getPath("signport");
                                                                    if (signport == null) {
                                                                        signport = "4880";
                                                                    }%>
                                                            <script type="text/javascript">
                                                                function start_addr() {
                                                                    var d1 = '{\n\
                                                                        \"Command\":\"ADDRESS\",\n\
                                                                        \"Token\":\"<%=token%>\",\n\
                                                                        \"ad1\":\"\",\n\
                                                                        \"ma1\":\"\",\n\
                                                                        \"te1\":\"\",\n\
                                                                        \"Response\":\"\",\n\
                                                                        \"CallbackUrl\":\"<%=fisso%>",\n\
                                                                    \"Response\":\"\"}';

                                                                    $.ajax({
                                                                        async: true,
                                                                        url: 'http://localhost:<%=signport%>/',
                                                                        dataType: 'TEXT',
                                                                        type: 'POST',
                                                                        contentType: 'application/json',
                                                                        data: d1,
                                                                        success: function (data, textStatus, jQxhr) {
                                                                            console.info(data);
                                                                            console.info(textStatus);
                                                                            console.info(jQxhr);
                                                                        },
                                                                        error: function (jqXhr, textStatus, errorThrown) {
                                                                            console.error("RAF: " + this.data);
                                                                            console.error("RAF: " + errorThrown);
                                                                            console.error("RAF: " + textStatus);
                                                                            console.error("RAF: " + jqXhr);
                                                                            document.getElementById('errorlargetext').innerHTML = "APPLICATION ERROR. CONNECTION REFUSED.";
                                                                            document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                                                                            document.getElementById('errorlarge').style.display = "block";
                                                                            return false;
                                                                        }
                                                                    });

                                                                }
                                                                function read_addr(token) {
                                                                    $.ajax({
                                                                        async: false,
                                                                        type: "POST",
                                                                        url: "Scan?type=checkADDR&token=" + token,
                                                                        success: function (data) {
                                                                            var arrayJson = JSON.parse(data);
                                                                            if (arrayJson[0] === 'true') {
                                                                                document.getElementById("heavy_address").value = arrayJson[1];
                                                                                document.getElementById("heavy_phonenu").value = arrayJson[2];
                                                                                document.getElementById("heavy_email").value = arrayJson[3];
                                                                                document.getElementById('infolarge').className = document.getElementById('infolarge').className + " in";
                                                                                document.getElementById('infolarge').style.display = "block";
                                                                                document.getElementById('infolargetext').innerHTML = "The customer data entered has been loaded!";
                                                                                return false;
                                                                            } else {
                                                                                document.getElementById('errorlargetext').innerHTML = "Customer data NOT FOUND!";
                                                                                document.getElementById('errorlarge').className = document.getElementById('infolarge').className + " in";
                                                                                document.getElementById('errorlarge').style.display = "block";
                                                                                return false;
                                                                            }
                                                                        }
                                                                    });
                                                                }

                                                            </script>

                                                            <button type="button" <%=disabilitatasti%> class="btn btn-outline dark tooltips" onclick="return start_addr();"
                                                                    title="Start Insert Address">
                                                                <i class="fa fa-map-o"></i>
                                                            </button>
                                                            <button type="button" <%=disabilitatasti%> class="btn btn-outline dark tooltips" 
                                                                    title="Read Address" onclick="return read_addr('<%=token%>');">
                                                                <i class="fa fa-map-signs"></i>
                                                            </button>

                                                            <%}%>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group <%=fgsearch%>" id="newuk_2">
                                                        <label><i class="fa fa-user font-blue"></i> Name <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_name" name="heavy_name"
                                                               maxlength="30"
                                                               onchange="return verificanomecogn();" 
                                                               onkeypress="return keysub(this, event);"
                                                               onkeyup="return modificaOAMSurname(this, event);"/>
                                                    </div>
                                                </div>

                                                <%if (Constant.is_IT) {%>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-credit-card font-blue uppercase"></i> Tax Code <span class='font-red' id="taxcodespan">*</span></label>
                                                        <input type="text" class="form-control" id="heavy_codfisc" name="heavy_codfisc" maxlength="16"
                                                               onchange="return checkcodfisc();" 
                                                               onkeypress="return keysub(this, event);" 
                                                               onkeyup="return fieldNOSPecial_1(this.id);"> 

                                                    </div>
                                                </div>
                                                <div class="col-md-4"><div class="form-group">
                                                        <input type="hidden" id="heavy_pno1" name="heavy_pno1" value="-">
                                                    </div>
                                                </div>
                                                <%} else if (Constant.is_UK) {%>
                                                <div class="col-md-4">
                                                    <span id="taxcodespan" style="display: none;"></span>
                                                    <input type="hidden" id="heavy_codfisc" name="heavy_codfisc" value="---" /> 
                                                </div>
                                                <div class="col-md-4"><div class="form-group">
                                                        <input type="hidden" id="heavy_pno1" name="heavy_pno1" value="-">
                                                    </div>
                                                </div>
                                                <%} else {%>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-credit-card font-blue"></i> Personal No. <span class='font-red' id ='heavy_pno1OBBL'>*</span></label>
                                                        <div class="clearfix">
                                                            <input type="text" class="form-control" 
                                                                   id="heavy_pno1" name="heavy_pno1" maxlength="20" 
                                                                   onkeypress="return keysub(this, event);"> 
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <span id="taxcodespan" style="display: none;"></span>
                                                    <input type="hidden" id="heavy_codfisc" name="heavy_codfisc" value="---" /> 
                                                </div>
                                                <%}%>
                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-flag font-blue"></i> Country <span class='font-red'>*</span></label>
                                                        <select class="form-control select2" id="heavy_country" 
                                                                onchange="return verifica_personalnumberCZ();"
                                                                name="heavy_country" disabled="disabled" 
                                                                onkeypress="return keysub(this, event);"></select>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-home font-blue"></i> City <span class='font-red'>*</span></label>
                                                        <input class="form-control" type="text" 
                                                               name="heavy_city_dis" id="heavy_city_dis" 
                                                               style="display: none;" maxlength="40"
                                                               onkeypress="return keysub(this, event);" 
                                                               onkeyup="return modificaOAMSurname(this, event);"/>

                                                        <div class="clearfix" id="heavy_city_div">
                                                            <select class="form-control select2" name="heavy_city" 
                                                                    id="heavy_city" disabled="disabled" 
                                                                    onkeypress="return keysub(this, event);" style="width: 100%;">
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%if (!Constant.is_IT) {%>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-flag font-blue"></i> Country of Citizenship <span class='font-red'>*</span></label>
                                                        <select class="form-control select2" 
                                                                id="heavy_cz_country"
                                                                name="heavy_cz_country" onchange="return verifica_personalnumberCZ();"
                                                                onkeypress="return keysub(this, event);">
                                                            <option value="---">None</option>
                                                            <%for (int i = 0; i < array_country.size(); i++) {%>
                                                            <option value="<%=array_country.get(i)[0]%>"><%=array_country.get(i)[1]%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <%}%>
                                                <div class="col-md-2" id="pepITA" style="display: none;">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> Client is PEP <span class='font-red'>*</span></label>
                                                        <div class="clearfix">
                                                            <select class="form-control select2" name="heavy_pepI" 
                                                                    id="heavy_pepI" onkeypress="return keysub(this, event);">
                                                                <option value="NO">No</option>
                                                                <option value="YES">Yes</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-home font-blue"></i> Address <span class='font-red'>*</span></label>

                                                        <input type="text" class="form-control" id="heavy_address" maxlength="100"
                                                               name="heavy_address" onkeypress="return keysub(this, event);" 

                                                               onkeyup="return modificaOAM_Add(this, event);"/> 

                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-home font-blue"></i> Zip Code 
                                                            <span class="font-red" id="zipcodelabel">*</span>
                                                        </label>

                                                        <input type="text" class="form-control uppercase" id="heavy_zipcode" 
                                                               name="heavy_zipcode" maxlength="10" 
                                                               onkeypress="return keysub(this, event);" 
                                                               onkeyup="return fieldNOSPecial_1(this.id);"> 

                                                    </div>
                                                </div>
                                                <%if (Constant.is_IT) {%>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-home font-blue"></i> District <span class='font-red'id="heavy_districtspan">*</span></label>
                                                        <input class="form-control" type="text" name="heavy_district_dis" 
                                                               id="heavy_district_dis" style="display: none;" readonly="readonly" 
                                                               onkeypress="return keysub(this, event);" maxlength="2"
                                                               onkeyup="return fieldNOSPecial_1(this.id);"/>
                                                        <div id="heavy_district_div">
                                                            <select class="form-control select2" id="heavy_district" name="heavy_district" disabled="disabled" onkeypress="return keysub(this, event);" style="width: 100%;">
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%} else {%>
                                                <div class="col-md-4">
                                                    <div class="form-group" style="display: none;">
                                                        <label><i class="fa fa-home font-blue"></i> District <span class='font-red'id="heavy_districtspan">*</span></label>
                                                        <input class="form-control" type="text" name="heavy_district_dis" 
                                                               id="heavy_district_dis" style="display: none;" readonly="readonly" 
                                                               onkeypress="return keysub(this, event);" maxlength="2"
                                                               onkeyup="return fieldNOSPecial_1(this.id);"/>
                                                        <div id="heavy_district_div">
                                                            <select class="form-control select2" id="heavy_district" name="heavy_district" disabled="disabled" onkeypress="return keysub(this, event);" style="width: 100%;">
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%}%>
                                                <!--CHZ-->


                                                <div class="clearfix"></div>


                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <h3 class="panel-title">Place of Birth <span class='font-red'>*</span></h3>
                                                        </div>
                                                        <div class="panel-body"> <div class="col-md-3">
                                                                <div class="form-group">
                                                                    <label><i class="fa fa-home font-blue"></i> City <span class='font-red'>*</span></label>

                                                                    <input type="text" class="form-control" name="heavy_pob_city" 
                                                                           id="heavy_pob_city" maxlength="40"
                                                                           onkeypress="return keysub(this, event);"
                                                                           onkeyup="return modificaOAMSurname(this, event);" /> 

                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <%if (Constant.is_IT) {%>
                                                                <div class="form-group">
                                                                    <label><i class="fa fa-home font-blue"></i> District <span class='font-red'id="heavy_pob_districtspan">*</span></label>

                                                                    <input type="text" class="form-control" name="heavy_pob_district_STR" 
                                                                           id="heavy_pob_district_STR" readonly="readonly" onkeypress="return keysub(this, event);" 
                                                                           maxlength="2"
                                                                           onkeyup="return fieldNOSPecial_1(this.id);" 
                                                                           style="display: none;" /> 
                                                                    <div id="heavy_pob_district_div">
                                                                        <select class="form-control select2" id="heavy_pob_district" 
                                                                                name="heavy_pob_district" onkeypress="return keysub(this, event);">
                                                                            <option value="---">None</option>
                                                                            <%for (int i = 0; i < array_district.size(); i++) {
                                                                            %>
                                                                            <option value="<%=array_district.get(i)[0]%>"><%=array_district.get(i)[1]%></option>
                                                                            <%}%>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <%} else {%>
                                                                <div class="form-group" style="display:none;">
                                                                    <label><i class="fa fa-home font-blue"></i> District <span class='font-red'id="heavy_pob_districtspan">*</span></label>
                                                                    <input type="text" class="form-control" name="heavy_pob_district_STR" 
                                                                           id="heavy_pob_district_STR" readonly="readonly" onkeypress="return keysub(this, event);" 
                                                                           maxlength="2"
                                                                           onkeyup="return fieldNOSPecial_1(this.id);" 
                                                                           style="display: none;" /> 
                                                                    <div id="heavy_pob_district_div">
                                                                        <select class="form-control select2" id="heavy_pob_district" 
                                                                                name="heavy_pob_district" onkeypress="return keysub(this, event);">
                                                                            <option value="---">None</option>
                                                                            <%for (int i = 0; i < array_district.size(); i++) {
                                                                            %>
                                                                            <option value="<%=array_district.get(i)[0]%>"><%=array_district.get(i)[1]%></option>
                                                                            <%}%>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <%}%>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group <%=fgsearch%>" id="newuk_7">
                                                                    <label><i class="fa fa-flag font-blue"></i> Country <span class='font-red'>*</span></label>
                                                                    <select class="form-control select2" id="heavy_pob_country" name="heavy_pob_country" onchange="return changedistrictpob();" onkeypress="return keysub(this, event);">
                                                                        <option value="---">None</option>
                                                                        <%for (int i = 0; i < array_country.size(); i++) {%>
                                                                        <option value="<%=array_country.get(i)[0]%>"><%=array_country.get(i)[1]%></option>
                                                                        <%}%>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-3">
                                                                <div class="form-group <%=fgsearch%>" id="newuk_3">
                                                                    <label><i class="fa fa-calendar font-blue"></i> Date <span class='font-red'>*</span></label>
                                                                    <input type="text" class="form-control date-picker" name="heavy_pob_date" 
                                                                           onchange="return ricercaclientestraniero(true);"
                                                                           id="heavy_pob_date" onkeypress="return keysub(this, event);" > 
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group" id="newuk_4">
                                                        <label><i class="fa fa-credit-card font-blue"></i> Identification Card <span class='font-red'>*</span></label>
                                                        <select class="form-control select2" 
                                                                id="heavy_identcard" name="heavy_identcard" 
                                                                onkeypress="return keysub(this, event);" style="width: 100%;">
                                                        </select>
                                                    </div>
                                                </div>
                                                <%for (int x = 0; x < array_identificationCard.size(); x++) {%>
                                                <input type="hidden" id="DE_<%=array_identificationCard.get(x)[0]%>" value="<%=array_identificationCard.get(x)[1]%>" />
                                                <%}%>
                                                <%if (!Constant.is_IT) {%>
                                                <div class="col-md-4">
                                                    <div class="form-group" id="newuk_5">
                                                        <label><i class="fa fa-flag font-blue"></i> Issuing Country <span class='font-red'>*</span></label>
                                                        <select class="form-control select2" 
                                                                id="heavy_cz_issuingcountry"
                                                                name="heavy_cz_issuingcountry"
                                                                onkeypress="return keysub(this, event);">
                                                            <option value="---">None</option>
                                                            <%for (int i = 0; i < array_country.size(); i++) {%>
                                                            <option value="<%=array_country.get(i)[0]%>"><%=array_country.get(i)[1]%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <%}%>
                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group" id="newuk_6" >
                                                        <label><i class="fa fa-credit-card font-blue"></i> Number of Id. Card <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control uppercase" id="heavy_numberidentcard" 
                                                               name="heavy_numberidentcard" maxlength="20" 
                                                               onkeypress="return keysub(this, event);"  
                                                               onkeyup="return modificaOAM(this, event);" /> 
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-calendar font-blue"></i> Issue Date <span class='font-red'>*</span></label>

                                                        <input type="text" class="form-control date-picker" id="heavy_issuedateidentcard"name="heavy_issuedateidentcard" maxlength="100" onkeypress="return keysub(this, event);"> 

                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-calendar font-blue"></i> Expiration Date <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control date-picker" id="heavy_exdateidentcard" 
                                                               name="heavy_exdateidentcard" maxlength="100" onchange="return checkheavy_exdateidentcard();" 
                                                               onkeypress="return keysub(this, event);" />
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-credit-card font-blue"></i> Issued By <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_issuedbyidentcard" name="heavy_issuedbyidentcard" 
                                                               maxlength="40" onkeypress="return keysub(this, event);" 
                                                               onkeyup="return modificaOAM_soloap(this, event);" /> 
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-credit-card font-blue"></i> Place of Issue <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_issuedplaceidentcard" 
                                                               name="heavy_issuedplaceidentcard" 
                                                               maxlength="40"
                                                               onkeypress="return keysub(this, event);" 
                                                               onkeyup="return modificaOAM_soloap(this, event);" /> 
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-envelope font-blue"></i> Email</label>
                                                        <input type="text" class="form-control"
                                                               id="heavy_email" name="heavy_email" 
                                                               onkeypress="return keysub(this, event);"
                                                               onkeyup="return fieldNOSPecial_2(this.id);"/> 
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-phone font-blue"></i> Phone Number</label>
                                                        <input type="text" class="form-control" id="heavy_phonenu" name="heavy_phonenu" onkeypress="return keysub(this, event);" 
                                                               onkeyup="return fieldOnlyNumber(this.id);"> 
                                                    </div>
                                                </div>
                                                <div class="col-md-4" id="dataverified" style="display: none;">
                                                    <div class="form-group">
                                                        <label>&nbsp;</label>
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="verdat" name="verdat" onkeypress="return keysub(this, event);" /> 
                                                            <label for="verdat">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> The data has been verified
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%if (!Constant.is_IT) {%>
                                                <div class="clearfix"></div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> International Sanctions <span class='font-red'>*</span></label>
                                                        <div class="clearfix">
                                                            <select class="form-control select2"
                                                                    name="heavy_sanctions" id="heavy_sanctions" onkeypress="return keysub(this, event);">
                                                                <option value="NO">No</option>
                                                                <option value="YES">Yes</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>


                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> Client is PEP <span class='font-red'>*</span></label>
                                                        <div class="clearfix">
                                                            <select class="form-control select2" name="heavy_pep" id="heavy_pep" onchange="return cz_pep();"
                                                                    onkeypress="return keysub(this, event);">
                                                                <option value="NO">No</option>
                                                                <option value="YES">Yes</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="pepcz" style="display: none;">
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label><i class="fa fa-user font-blue"></i> Position of the PEP <span class='font-red'>*</span></label>
                                                            <div class="clearfix">
                                                                <input type="text" class="form-control" id="pep_position" name="pep_position" 
                                                                       onkeypress="return keysub(this, event);"  maxlength="100"
                                                                       onkeyup="return modificaOAM(this, event);" /> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3">
                                                        <div class="form-group">
                                                            <label><i class="fa fa-user font-blue"></i> Country PEP empowered <span class='font-red'>*</span></label>
                                                            <div class="clearfix">
                                                                <select class="form-control select2" name="pep_country" id="pep_country"
                                                                        onkeypress="return keysub(this, event);">
                                                                    <option value="---">None</option>
                                                                    <%for (int i = 0; i < array_country.size(); i++) {%>
                                                                    <option value="<%=array_country.get(i)[0]%>"><%=array_country.get(i)[1]%></option>
                                                                    <%}%>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> Transaction Reason <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_transactionre" name="heavy_transactionre" 
                                                               maxlength="100" onkeypress="return keysub(this, event);" onkeyup="return modificaOAM(this, event);"> 
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> Money Source <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_moneysource" 
                                                               name="heavy_moneysource" maxlength="100" onkeypress="return keysub(this, event);" onkeyup="return modificaOAM(this, event);"> 
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label><i class="fa fa-user font-blue"></i> Customer's Occupation <span class='font-red'>*</span></label>
                                                        <input type="text" class="form-control" id="heavy_occupation" 
                                                               name="heavy_occupation" maxlength="100" onkeypress="return keysub(this, event);" onkeyup="return modificaOAM(this, event);"> 
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <%}%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                                <!-- customer information pg -->
                                <div class="col-md-12" id="custinfo_2">
                                    <div class="portlet box blue">
                                        <div class="portlet-title">
                                            <div class="caption">
                                                <i class="fa fa-user"></i>
                                                <span class="caption-subject">KYC - Know Your Customer</span>
                                            </div>
                                        </div>
                                        <div class="portlet-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label>Company</label><p class='ab'></p>
                                                        <select class="form-control select2" name="company" id="company" onkeypress="return keysub(this, event);">
                                                            <%for (int i = 0; i < array_listCompany.size(); i++) {%>
                                                            <option value="<%=array_listCompany.get(i).getNdg()%>">
                                                                <%=array_listCompany.get(i).getRagione_sociale() + " - " + array_listCompany.get(i).getCognome() + " " + array_listCompany.get(i).getNome()%>
                                                            </option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%if (Constant.is_IT) {%>
                        <div class="row">                               
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <div class="col-md-12 ">
                                <div class="md-checkbox">
                                    <input type="checkbox" id="kycpres" name="kycpres" 
                                           class="md-checkbox" onkeypress="return keysub(this, event);"> 
                                    <label for="kycpres">
                                        <span></span>
                                        <span class="check"></span>
                                        <span class="box"></span> KYC User Reporting
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                        </div>
                        <%}%>
                        <%if (!Constant.is_IT) {%>
                        <div class="row">                               
                            <div class="col-md-12">
                                <hr>
                            </div>
                            <div class="col-md-12 ">
                                <div class="md-checkbox">
                                    <input type="checkbox" id="op_sos" name="op_sos" 
                                           onchange="return opsos();"> 
                                    <label for="op_sos">
                                        <span></span>
                                        <span class="check"></span>
                                        <span class="box"></span> Suspicious Operation
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <hr>
                            </div>
                        </div>
                        <%}%>
                        <div class="row">
                            <div class="col-md-12">
                                <center><button type="submit" class="btn btn-lg red btn-block" id="butconf"><i class="fa fa-save"></i> Confirm Transaction</button></center>
                            </div>                            
                        </div>  
                        <input type="hidden" id="showanagVALUE" name="showanagVALUE" value=""/>
                        <input type="hidden" id="showanagNEWUK" name="showanagNEWUK" value="NO"/>
                    </form>
                    <%}%>
                    <input type="hidden" name="esito" value=""/>

                    <%} else {%>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert alert-danger">
                                <strong>000 - Head Office can not perform transaction operation.</strong>
                            </div>
                        </div>
                    </div>
                    <%}%>

                </div>
                <!-- END CONTENT -->
                <!-- BEGIN QUICK SIDEBAR -->
                <!-- END QUICK SIDEBAR -->

            </div>
            <!-- END CONTAINER -->
            <!-- BEGIN FOOTER -->
            <div class="page-footer">
                <div class="page-footer-inner"> <%=et_index.getFooter()%></div>
                <div class="scroll-to-top">
                    <i class="icon-arrow-up"></i>
                </div>
            </div>
            <input type="hidden" id="ipaddress" value=""/>



            <!-- END FOOTER -->
            <!-- [if lt IE 9]>
            <script src="../assets/global/plugins/respond.min.js"></script>
            <script src="../assets/global/plugins/excanvas.min.js"></script> 
            <![endif] -->
            <!-- BEGIN CORE PLUGINS -->
            <script src="assets/soop/jquery-3.6.4.min.js" type="text/javascript"></script>
            <script src="assets/soop/bootstrap-5.2.3/dist/js/bootstrap.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>

            <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
            <!--<script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>-->
            <script src="assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
            <!-- END CORE PLUGINS -->
            <!-- BEGIN PAGE LEVEL PLUGINS -->
            <script src="assets/soop/select2-4.0.13/js/select2.full.min.js" type="text/javascript"></script>
            <%if (!Constant.is_CZ) {%>
            <script src="assets/soop/js/select2-tab-fix.min.js" type="text/javascript"></script>
            <%} else {%>
            <script src="assets/soop/js/select2-tab-fix.min.cz.js" type="text/javascript"></script>
            <%}%>

            <script src="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
            <!-- END PAGE LEVEL PLUGINS -->
            <!-- BEGIN THEME GLOBAL SCRIPTS -->
            <script src="assets/global/scripts/app.min.js" type="text/javascript"></script>
            <!-- END THEME GLOBAL SCRIPTS -->
            <!-- BEGIN PAGE LEVEL SCRIPTS -->
            
            <script src="assets/soop/bootstrap-select-1.13.14/js/bootstrap-select.min.js" type="text/javascript"></script>
            
            <script src="assets/pages/scripts/components-date-time-pickers.min.js" type="text/javascript"></script>
            <script src="assets/soop/js/form-input-mask.min.js" type="text/javascript"></script>
            <!-- END PAGE LEVEL SCRIPTS -->
            
            <!-- BEGIN THEME LAYOUT SCRIPTS -->
            <script src="assets/layouts/layout/scripts/layout.min.js" type="text/javascript"></script>
            <script src="assets/layouts/layout/scripts/demo.min.js" type="text/javascript"></script>
            <script src="assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
            <!-- END CORE PLUGINS -->
            <!-- BEGIN PAGE LEVEL PLUGINS -->
            <!-- END PAGE LEVEL PLUGINS -->
            <!-- BEGIN THEME GLOBAL SCRIPTS -->
            <script src="assets/soop/js/input-mask_buy.js" type="text/javascript"></script>
            <!-- END THEME LAYOUT SCRIPTS -->
            <script src="assets/global/scripts/datatable.js" type="text/javascript"></script>
            <script src="assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
            <!-- BEGIN THEME GLOBAL SCRIPTS -->


            <%if (Constant.tr_1325) {%>

            <%} else {%>

            <script type="text/javascript">
                                               jQuery(document).ready(function () {
                                                   var dt = function () {
                                                       var e = $("#sample_0");
                                                       e.dataTable({
                                                           language: {aria: {},
                                                               sProcessing: "Processo...",
                                                               emptyTable: "Nessun risultato trovato",
                                                               info: "Mostra _START_ di _END_ su _TOTAL_ risultati",
                                                               infoEmpty: "Nessun risultato trovato",
                                                               infoFiltered: "(filtrati su _MAX_ totali)",
                                                               lengthMenu: "Mostra _MENU_", search: "Trova:",
                                                               zeroRecords: "Nessun risultato trovato",
                                                               paginate: {previous: "Precedente", next: "Successiva", last: "Ultima", first: "Prima"}},
                                                           scrollX: true,
                                                           scrollY: false,
                                                           columnDefs: [
                                                               {orderable: !1, targets: [0]},
                                                               {orderable: !1, targets: [1]},
                                                               {orderable: !1, targets: [2]},
                                                               {orderable: !1, targets: [3]},
                                                               {orderable: !1, targets: [4]},
                                                               {orderable: !1, targets: [5]},
                                                               {orderable: !1, targets: [6]},
                                                               {orderable: !1, targets: [7]},
                                                               {orderable: !1, targets: [8]},
                                                               {orderable: !1, targets: [9]},
                                                               {orderable: !1, targets: [10]},
                                                               {orderable: !1, targets: [11]},
                                                               {orderable: !1, targets: [12]},
                                                               {orderable: !1, targets: [13]},
                                                               {orderable: !1, targets: [14]},
                                                               {orderable: !1, targets: [15]},
                                                               {orderable: !1, targets: [16]},
                                                               {orderable: !1, targets: [17]},
                                                               {orderable: !1, targets: [18]}
                                                           ],
                                                           order: [],
                                                           dom: "<t>"
                                                       });
                                                   };
                                                   jQuery().dataTable && dt();
                                               }
                                               );
            </script>
            <%}%>
            <script type="text/javascript">

                $(document).ready(function () {
                    $('#unlockratesel').select2({
                        dropdownAutoWidth: true,
                        placeholder: "None",
                        allowClear: false
                    });
                    window.history.pushState(null, "", window.location.href);
                    window.onpopstate = function () {
                        window.history.pushState(null, "", window.location.href);
                    };
                });
            </script>
    </body>
</html>