<%@page import="rc.so.entity.NC_transaction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="rc.so.util.Etichette"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title>Mac2.0 - Paymat</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="assets/soop/fontg/fontsgoogle1.css" rel="stylesheet" type="text/css" />

        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/bootstrap-5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
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

        <script type="text/javascript" src="assets/soop/js/jquery.fancybox.js?v=2.1.5"></script>
        <link rel="stylesheet" type="text/css" href="assets/soop/css/jquery.fancybox.css?v=2.1.5" media="screen" />
        <script type="text/javascript" src="assets/soop/js/fancy.js"></script>
        <script src="assets/soop/js/controlli.js" type="text/javascript"></script>




        <script type="text/javascript">
            function changepaymentmode() {
                var kind = document.getElementById('kind_1').value;
                if (kind === "" || kind === "...") {
                    document.getElementById('ex6').style.display = 'none';
                    document.getElementById('ex6B').style.display = 'none';
                    return false;
                }
                if (kind === '01') {
                    document.getElementById('ex6').style.display = 'none';
                } else {
                    document.getElementById('ex6').style.display = '';
                }
                if (kind !== '06') {
                    document.getElementById('ex6B').style.display = 'none';
                } else {
                    document.getElementById('ex6B').style.display = '';
                }
            }

            function submitonEnter(idform) {
                var keycode;
                if (window.event)
                    keycode = window.event.keyCode;
                else if (e)
                    keycode = e.which;
                if (keycode + "" === "13") {
                    checknumb(idform);
                }
            }

            function checknumb() {
                if (document.getElementById('numb1') !== null) {
                    var numb = document.getElementById('numb1').value.trim();
                    if (!isPhone(numb, 8, 15)) {
                        document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                        document.getElementById("errorlarge").style.display = "block";
                        document.getElementById("errorlargetext").innerHTML = "Error! The number entered is incorrect.";
                        return false;
                    }
                    var numb2 = document.getElementById('numb2').value.trim();
                    if (numb !== numb2) {
                        document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                        document.getElementById("errorlarge").style.display = "block";
                        document.getElementById("errorlargetext").innerHTML = "Error! The numbers entered do not match.";
                        return false;
                    }
                }
                if (document.getElementById('ex6B').style.display === '') {
                    var posnum = document.getElementById('posnum').value.trim();
                    if (posnum === "") {
                        document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                        document.getElementById("errorlarge").style.display = "block";
                        document.getElementById("errorlargetext").innerHTML = "Error! Must be complete field with <span class='font-red'>*</span>.";
                        return false;
                    }
                }

                document.getElementById("modalwaitbutton").click();


            }

            function loadpage() {
                if (document.getElementById('numb1') !== null) {
                    document.getElementById('numb1').focus();
                }
                changepaymentmode();
                inputvirgola();
                $("#numb1,#numb2").on("copy cut paste drop", function () {
                    return false;
                });
            }

        </script>

    </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white" onload="return loadpage();">


        <div class="modal fade bs-modal-lg" id="errorlarge" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
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
        <div id="modalwait" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title"><i class="fa fa-spinner fa-spin"></i> Processing...</h4>
                    </div>
                    <div class="modal-body">
                        <p>
                            Wait until the operation result... (NOT reload this page)
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalwaitTEST" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
            <button type="button" data-toggle="modal" data-target="#modalwait" id="modalwaitbutton" style="width: 0px;"></button>
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
            <%@ include file="menu/menu_es3.jsp"%>
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
                    <!--    VUOTO RAF  -->
                    <!-- END THEME PANEL -->
                    <!-- BEGIN PAGE BAR -->
                    <%@ include file="menu/shortcuts.jsp"%>
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <div class="row">
                        <div class="col-md-11">
                            <h3 class="page-title">External Services <small><b>Paymat - Confirm Transaction</b></small></h3>
                        </div>
                        <div class="col-md-1" style="text-align: right;">
                            <img src="assets/soop/img/logocl.png" alt="" class="img-responsive" style="text-align: right;"/> 
                        </div>
                    </div>
                    <%
                        String cod = Utility.safeRequest(request, "cod");
                        String esito = Utility.safeRequest(request, "esito");
                        String classal = "alert-info";
                        String classfa = "fa-exclamation-triangle";
                        String msg = "Warning";
                        String msg1 = "No operation";
                        if (esito.equalsIgnoreCase("ok")) {
                            classal = "alert-success";
                            classfa = "fa-check";
                            msg = "Success";
                            msg1 = "Operation completed successfully.";
                        } else if (esito.equals("ko1")) {
                            classal = "alert-danger";
                            classfa = "fa-exclamation-triangle";
                            msg = "Error";
                            msg1 = Utility.safeRequest(request, "errmsg");
                        }
                        if (!esito.equals("")) {
                    %>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert <%=classal%>">
                                <strong><%=msg%> <i class="fa <%=classfa%>"></i></strong> <%=msg1%>
                            </div>
                        </div>
                    </div>
                    <%}
                        if (!Utility.safeRequest(request, "paynew").equals("")) {
                            String fil = Engine.getFil()[0];
                            String paynew = Utility.safeRequest(request, "paynew");
                            String bra = Utility.safeRequest(request, "bra");
                            String idbra = Utility.safeRequest(request, "idbra");
                            String codtaglio = Utility.safeRequest(request, "codtaglio");
                            String tipolo = Utility.safeRequest(request, "tipolo");
                            String desc = Utility.safeRequest(request, "desc");
                            if (!desc.contains("€")) {
                                desc = Utility.getStringUTF8(desc);
                            }

                            String tipoprodotto = Utility.safeRequest(request, "tipoprodotto");

                            String[] value_NC = Engine.get_temp_paymat(codtaglio);
                            ArrayList<String[]> array_kind_payment = null;
                            if (value_NC != null) {
                                array_kind_payment = Engine.nc_causal_payment_support(fil, value_NC[0], value_NC[1]);
                            } else {
                                array_kind_payment = Engine.kind_payment();
                            }

                            ArrayList<String[]> array_credit_card = Engine.credit_card(fil);
                    %>
                    <form id="exec_paymat" action="Operazioni?type=exec_paymat" method="post" onsubmit="return checknumb();">
                        <input type="hidden" name="paynew" value="<%=paynew%>"/>
                        <input type="hidden" name="bra" value="<%=bra%>"/>
                        <input type="hidden" name="idbra" value="<%=idbra%>"/>
                        <input type="hidden" name="codtaglio" value="<%=codtaglio%>"/>
                        <input type="hidden" name="tipolo" value="<%=tipolo%>"/>
                        <input type="hidden" name="desc" value="<%=desc%>"/>
                        <input type="hidden" name="tipoprodotto" value="<%=tipoprodotto%>"/>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <b>Code:</b> <%=codtaglio%>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <b>Brand:</b> <%=bra%>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <b>Description:</b> <%=desc%>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <b>Type:</b> <%=tipoprodotto%>
                                </div>
                            </div>
                        </div>
                        <div class="row"><hr></div>
                        <div class="row">
                            <%if (tipoprodotto.equals("Carte Internazionali")) {%>
                            <input type="hidden" name="numb" value="-"/>
                            <%} else {%>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Phone Number <span class="font-red">*</span></label>
                                    <div class="input-icon">
                                        <i class="fa fa-phone font-blue"></i>
                                        <input class="form-control" type="text" autocomplete="off"  
                                               onkeypress="return keysub(this, event);" onkeyup="return fieldOnlyNumber(this.id);"
                                               name="numb" id="numb1"> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Confirm Phone Number <span class="font-red">*</span></label>
                                    <div class="input-icon">
                                        <i class="fa fa-phone font-blue"></i>
                                        <input class="form-control" type="text" autocomplete="off"  
                                               onkeypress="return keysub(this, event);" onkeyup="return fieldOnlyNumber(this.id);"
                                               id="numb2"> 
                                    </div>
                                </div>
                            </div>



                            <%}%>

                        </div>
                        <div class="row"><hr></div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Payment mode <span class="font-red">*</span></label>
                                    <select class="form-control select2" id="kind_1" name="kind_1" placeholder="..."
                                            onchange="return changepaymentmode();">
                                        <%for (int i = 0; i < array_kind_payment.size(); i++) {%>
                                        <option value="<%=array_kind_payment.get(i)[0]%>"><%=array_kind_payment.get(i)[1]%></option>
                                        <%}%>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6" id="ex6">
                                <label>Pos <span class="font-red">*</span></label>
                                <select class="form-control select2" id="pos_1" name="pos_1" placeholder="...">
                                    <%for (int i = 0; i < array_credit_card.size(); i++) {%>
                                    <option value="<%=array_credit_card.get(i)[0]%>"><%=array_credit_card.get(i)[1]%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="col-md-6" id="ex6B">
                                <label>CC Number <span class="font-red">*</span></label>
                                <input type="text" class="form-control" id="posnum" 
                                       name="posnum" maxlength="4" onkeyup="return fieldOnlyNumber(this.id);"/>
                            </div>
                        </div>
                        <div class="row"><hr></div>

                        <div class="row" >
                            <div class="col-md-12">
                                <center><button type="submit" class="btn btn-lg green-jungle btn-block" id="butconf"><i class="fa fa-save"></i> Confirm Transaction</button></center>
                            </div>
                        </div>
                    </form>
                    <%} else {%>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert alert-danger">
                                <strong>Error <i class="fa fa-exclamation-triangle"></i></strong> No Operation available. Close this page.
                            </div>
                        </div>
                    </div>
                    <button onclick="self.close();" class="btn red btn-circle btn-outline" id="clbtn"><i class="fa fa-window-close"></i> Close </button>
                    <%}%>
                    <!-- END CONTENT -->
                    <!-- BEGIN QUICK SIDEBAR -->
                    <!-- END QUICK SIDEBAR -->
                </div>
            </div>
            <!-- END CONTAINER -->
            <!-- BEGIN FOOTER -->
            <div class="page-footer">
                <div class="page-footer-inner"> <%=et_index.getFooter()%></div>
                <div class="scroll-to-top">
                    <i class="icon-arrow-up"></i>
                </div>
            </div>
            <!-- END FOOTER -->
            <!-- BEGIN CORE PLUGINS -->
            <script src="assets/soop/jquery-3.6.4.min.js" type="text/javascript"></script>
            <script src="assets/soop/bootstrap-5.2.3/dist/js/bootstrap.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>

            <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js" type="text/javascript"></script>
            <!-- END CORE PLUGINS -->
            <!-- BEGIN PAGE LEVEL PLUGINS -->
            <script src="assets/soop/select2-4.0.13/js/select2.full.min.js" type="text/javascript"></script>
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
            <script src="assets/global/scripts/datatable.js" type="text/javascript"></script>
            <script src="assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
            <!-- END CORE PLUGINS -->
            <!-- BEGIN PAGE LEVEL PLUGINS -->
            <!-- END PAGE LEVEL PLUGINS -->
            <!-- BEGIN THEME GLOBAL SCRIPTS -->
            <!-- END THEME LAYOUT SCRIPTS -->
            <!-- BEGIN THEME GLOBAL SCRIPTS -->

            <script type="text/javascript">

                        $(document).ready(function () {
                            window.history.pushState(null, "", window.location.href);
                            window.onpopstate = function () {
                                window.history.pushState(null, "", window.location.href);
                            };
                        });
            </script>
    </body>

</html>
