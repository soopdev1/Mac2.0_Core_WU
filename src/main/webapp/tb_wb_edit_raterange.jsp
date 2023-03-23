<%@page import="rc.so.entity.Branch"%>
<%@page import="rc.so.util.Constant"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.util.Engine"%>
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
        <title>Mac2.0</title>
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


        <link href="assets/soop/bootstrap-select-1.13.14/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/select2-4.0.13/css/select2.min.css" rel="stylesheet" type="text/css" />
        
        <link href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />

        <link href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
        
        <link href="assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/bootstrap-select-1.13.14/css/bootstrap-select.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/soop/select2-4.0.13/css/select2.min.css" rel="stylesheet" type="text/css" />
        
        <link href="assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />

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
        <script src="assets/soop/js/moment.js" type="text/javascript"></script>




        <script src="assets/soop/js/controlli.js" type="text/javascript"></script>
        <%
            String decimal = Constant.decimal;
            String thousand = Constant.thousand;
            String startvalue = "0" + decimal + "00";
        %>
        <script type="text/javascript">
            function checkdescr() {
                var min = document.getElementById("min").value.trim();
                var max = document.getElementById("max").value.trim();
                if (min === "" || max === "") {
                    var ermsg = "You must complete all fields.";
                    document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                    document.getElementById("errorlarge").style.display = "block";
                    document.getElementById("errorlargetext").innerHTML = ermsg;
                    return false;
                }

                var dt_val = document.getElementById("dt_val").value.trim();

                if (!moment(dt_val, 'DD/MM/YYYY hh:mm').isValid() || dt_val === "31/12/1899 00:00") {
                    document.getElementById("dt_val").value = "";
                    var ermsg = "'Date Apply' are incorrect.";
                    document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                    document.getElementById("errorlarge").style.display = "block";
                    document.getElementById("errorlargetext").innerHTML = ermsg;
                    return false;
                }
                var nowdate = moment();
                var pobdate1 = moment(dt_val, 'DD/MM/YYYY hh:mm', true);
                if (nowdate.isSameOrAfter(pobdate1)) {
                    var ermsg = "'Date Apply' are incorrect. The date must be after the current.";
                    document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                    document.getElementById("errorlarge").style.display = "block";
                    document.getElementById("errorlargetext").innerHTML = ermsg;
                    return false;
                }
            }

            function valid(sel, val) {
                var verified = document.getElementById(sel);
                if (verified.checked) {
                    $('#' + val).val('').change();
                    document.getElementById(val).disabled = true;
                } else {
                    document.getElementById(val).disabled = false;
                }
            }

            function loadpage() {
                formatValueDecimal_1(document.getElementById('min'), '<%=thousand%>', '<%=decimal%>');
                formatValueDecimal_1(document.getElementById('max'), '<%=thousand%>', '<%=decimal%>');
                inputvirgola();
            }

        </script>
    </head>
    <!-- END HEAD -->

    <body class="page-full-width page-content-white" onload="loadpage();">
        <div class="modal fade bs-modal-lg" id="errorlarge" tabindex="-1" role="dialog" aria-hidden="true">
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
        <!-- BEGIN HEADER -->
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN MENU -->
            <!-- END MENU -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <!--    VUOTO RAF  -->
                    <!-- END THEME PANEL -->
                    <!-- BEGIN PAGE BAR -->
                    <!-- END PAGE BAR -->
                    <!-- BEGIN PAGE TITLE-->
                    <div class="clearfix"></div>
                    <%

                        String view = request.getParameter("view");
                        if (view == null) {
                            view = "0";
                        }

                        String ra_code = request.getParameter("ra_code");
                        String fi_min = request.getParameter("ra_min");

                        ArrayList<String[]> array_kind = Engine.list_all_kind("000");
                        ArrayList<String[]> level_rate = Engine.select_level_rate();
                        
                        String[] fix_value = Engine.get_site_levelrate(fi_min);
                        if (fix_value != null) {
                            String fi_max = fix_value[2];
                            if (view.equals("1")) {%>
                    <%} else {%>
                    <form class="form-horizontal" role="form" name="f1" method="post" action="Edit?type=edit_wb_ratera" onsubmit="return checkdescr();">
                        <input type="hidden" name="min_old" value="<%=fi_min%>"/>
                        <input type="hidden" name="ra_code" value="<%=ra_code%>"/> 
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PORTLET-->
                                <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="icon-wrench font-blue"></i>
                                            <span class="caption-subject font-blue bold uppercase">Edit Level Rate</span>
                                        </div>
                                        <div class="tools"> 
                                            <div class="tools"> 
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <label class="col-md-3 control-label">Date Apply</label>
                                                        <div class="col-md-5">
                                                            <input type="text" class="form-control form_datetime" 
                                                                   id="dt_val" name="dt_val" onkeypress="return keysub(this, event);" 
                                                                   data-date-start-date="+0d" value=""/>
                                                        </div>
                                                        <div class="col-md-4 pull-right">
                                                            <button type="submit" class="btn btn-outline blue"><i class="fa fa-save"></i> Save changes</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Kind</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control uppercase" 
                                                           name="locfig" value="<%=Utility.formatAL(ra_code, array_kind, 1)%>" 
                                                           disabled="disabled"> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Min</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" value="<%=fi_min%>" id="min" name="min" 
                                                           onchange="return formatValueDecimal_1_change(this, '<%=thousand%>', '<%=decimal%>');"
                                                           onkeypress="return keysub(this, event);"> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Max</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" value="<%=fi_max%>" id="max" name="max" 
                                                           onchange="return formatValueDecimal_1_change(this, '<%=thousand%>', '<%=decimal%>');"
                                                           onkeypress="return keysub(this, event);"> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Applied Level</label>
                                                <div class="col-md-9">
                                                    <select class="form-control select2" id="sell" name="sell" data-container="body"
                                                            onkeypress="return keysub(this, event);">
                                                        <%for (int i = 0; i < level_rate.size(); i++) {%>
                                                        <%if (level_rate.get(i)[1].equalsIgnoreCase(fix_value[3])) {%>
                                                        <option value="<%=level_rate.get(i)[1].toUpperCase()%>" selected="selected"><%=level_rate.get(i)[1].toUpperCase()%></option>
                                                        <%} else {%>
                                                        <option value="<%=level_rate.get(i)[1].toUpperCase()%>"><%=level_rate.get(i)[1].toUpperCase()%></option>
                                                        <%}%>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <%}
                    } else {
                    %>

                    <%}%>
                    <%
                        String esito = request.getParameter("esito");
                        if (esito == null) {
                            esito = "";
                        }
                        String classal = "alert-info";
                        String classfa = "fa-exclamation-triangle";
                        String msg = "Warning";
                        String msg1 = "No operation";
                        if (esito.equals("ok") || esito.equals("true")) {
                            classal = "alert-success";
                            classfa = "fa-check";
                            msg = "Success";
                            msg1 = "Operation completed successfully.";
                        } else if (esito.equals("koins") || esito.equals("false")) {
                            classal = "alert-danger";
                            classfa = "fa-exclamation-triangle";
                            msg = "Error";
                            msg1 = "The operation could not be completed.";
                        } else if (esito.equals("kodup")) {
                            classal = "alert-danger";
                            classfa = "fa-exclamation-triangle";
                            msg = "Error";
                            msg1 = "The operation could not be completed. This configuration is already present.";
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
                    <%}%>
                    <!-- BEGIN CONTENT -->
                    <!-- END PAGE TITLE-->
                    <!-- END PAGE HEADER-->
                </div>
                <!-- END CONTENT -->
                <!-- BEGIN QUICK SIDEBAR -->
                <!-- END QUICK SIDEBAR -->
            </div>
            <!-- END CONTAINER -->
            <!-- BEGIN FOOTER -->
            <!-- END FOOTER -->
            <!--[if lt IE 9]>
                <script src="../assets/global/plugins/respond.min.js"></script>
                <script src="../assets/global/plugins/excanvas.min.js"></script> 
            <![endif]-->
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
            <!-- END PAGE LEVEL PLUGINS -->
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

            <input type="text" id="test1" name="test1" style="display: none; width: 1px;"/>

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
