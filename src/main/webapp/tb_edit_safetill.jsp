<%@page import="rc.so.entity.Branch"%>
<%@page import="rc.so.util.Utility"%>
<%@page import="java.util.ArrayList"%>
<%@page import="rc.so.util.Engine"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String link_value = Engine.verifyUser(request);
    if(link_value!=null){
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
        <script src="assets/soop/js/controlli.js" type="text/javascript"></script>
        
        
        
        
        <script type="text/javascript">
            function checkdescr() {
                var descr = document.getElementById("descr").value.trim();
                if (descr === "") {
                    var ermsg = "Field 'Description' cannot be blank.";
                    document.getElementById("errorlarge").className = document.getElementById("errorlarge").className + " in";
                    document.getElementById("errorlarge").style.display = "block";
                    document.getElementById("errorlargetext").innerHTML = ermsg;
                    return false;
                }
                
                var seall = document.getElementById('seall').checked;
                var branch = document.getElementById('branch').value;
                if (branch === "" && !seall) {
                    var ermsg = "You must select at least one branch.";
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
        </script>
    </head>
    <!-- END HEAD -->
    <body class="page-full-width page-content-white" onload="return inputvirgola();">
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
                    <!--VUOTO RAF-->
                    <div class="clearfix"></div>
                    <%
                        
                        String view = request.getParameter("view");
                            if (view == null) {
                                view = "0";
                            }
                        String fil = request.getParameter("fil");
                        ArrayList<Branch> array_branch = Engine.list_branch_enabled();
                        ArrayList<String[]> array_till = Engine.list_till(fil);
                        String sa_code = request.getParameter("sa_code");
                        if (sa_code != null) {

                            String descr = Utility.formatAL(sa_code, array_till, 1);
                            String type = Utility.formatAL(sa_code, array_till, 2);
                            String ch = "";
                            if (type.equals("0")) {
                                ch = "checked";
                            }
                            String stat = Utility.formatAL(sa_code, array_till, 3);
                            String st = "";
                            if (stat.equals("0")) {
                                st = "checked";
                            }
                            
                            if (view.equals("1")) {
                    %>
                    <form class="form-horizontal" role="form" name="f1" method="post">    
                    <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PORTLET-->
                                <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="icon-eye font-blue"></i>
                                            <span class="caption-subject font-blue bold uppercase">View Safe/Till - Branch: <%=fil%></span>
                                        </div>
                                        <div class="tools"> 
                                            
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Code</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control uppercase" 
                                                           value="<%=sa_code%>" 
                                                           readonly="readonly"> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Description</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" readonly="readonly" value="<%=descr%>" onkeypress="return keysub(this, event);"> 
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Type</label>
                                                <div class="col-md-9">
                                                    <input type="checkbox" class="make-switch" <%=ch%> readonly="readonly"
                                                           name="typetill" id="typetill" data-size="normal" data-on-color="primary" data-off-color="info"
                                                           data-on-text="<span class='tabnow'>Safe</span>" data-off-text="<span class='tabnow'>Till</span>"
                                                           onkeypress="return keysub(this, event);">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Status</label>
                                                <div class="col-md-9">
                                                    <input type="checkbox" class="make-switch" <%=st%> readonly="readonly"
                                                           name="status" id="status" data-size="normal" data-on-color="success" data-off-color="danger"
                                                           data-on-text="<span class='tabnow'>Enabled</span>" data-off-text="<span class='tabnow'>Disabled</span>"
                                                           onkeypress="return keysub(this, event);">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <%}else{%>
                    
                    <form class="form-horizontal" role="form" name="f1" action="Edit?type=edit_till" method="post" onsubmit="return checkdescr();">
                        <input type="hidden" name="fil" value="<%=fil%>"/>
                        <input type="hidden" name="view" value="<%=view%>"/>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PORTLET-->
                                <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="icon-wrench font-blue"></i>
                                            <span class="caption-subject font-blue bold uppercase">Edit Safe/Till</span>
                                        </div>
                                        <div class="tools"> 
                                            <button type="submit" class="btn btn-outline blue"><i class="fa fa-save"></i> Save changes</button>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        
                                        <div class="form-body">
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Branch</label>
                                                <div class="col-md-6">
                                                    <select class="form-control select2" name="listbranch" id="branch" multiple>
                                                        <%for (int j = 0; j < array_branch.size(); j++) {%>
                                                        <option value="<%=array_branch.get(j).getCod()%>">
                                                            <%=array_branch.get(j).getCod()%> - <%=array_branch.get(j).getDe_branch()%>
                                                        </option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">

                                                    <div class="md-checkbox">
                                                        <input type="checkbox" id="seall" name="seall" class="md-checkbox" onchange="return valid('seall', 'branch');"> 
                                                        <label for="seall">
                                                            <span></span>
                                                            <span class="check"></span>
                                                            <span class="box"></span> Select All
                                                        </label>
                                                    </div>

                                                </div>
                                            </div>
                                            <hr> 
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Code</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control uppercase" 
                                                           name="sa_code" value="<%=sa_code%>" 
                                                           readonly="readonly"> 
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Description</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" id="descr" name="descr" value="<%=descr%>" onkeypress="return keysub(this, event);"> 
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Type</label>
                                                <div class="col-md-9">
                                                    <input type="checkbox" class="make-switch" <%=ch%>
                                                           name="typetill" id="typetill" data-size="normal" data-on-color="primary" data-off-color="info"
                                                           data-on-text="<span class='tabnow'>Safe</span>" data-off-text="<span class='tabnow'>Till</span>"
                                                           onkeypress="return keysub(this, event);">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Status</label>
                                                <div class="col-md-9">
                                                    <input type="checkbox" class="make-switch" <%=st%>
                                                           name="status" id="status" data-size="normal" data-on-color="success" data-off-color="danger"
                                                           data-on-text="<span class='tabnow'>Enabled</span>" data-off-text="<span class='tabnow'>Disabled</span>"
                                                           onkeypress="return keysub(this, event);">
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <%}} else {%>
                    <form class="form-horizontal" role="form" name="f1" action="Edit?type=ins_newtill" method="post" onsubmit="return checkdescr();">
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BEGIN PORTLET-->
                                <div class="portlet light bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="icon-plus font-blue"></i>
                                            <span class="caption-subject font-blue bold uppercase">New Safe/Till</span>
                                        </div>
                                        <div class="tools"> 
                                            <button type="submit" class="btn btn-outline blue"><i class="fa fa-save"></i> Save</button>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="form-group">
                                                <label class="col-md-3 control-label">Branch</label>
                                                <div class="col-md-6">
                                                    <select class="form-control select2" name="listbranch" id="branch" multiple>
                                                        <%for (int j = 0; j < array_branch.size(); j++) {%>
                                                        <option value="<%=array_branch.get(j).getCod()%>">
                                                            <%=array_branch.get(j).getCod()%> - <%=array_branch.get(j).getDe_branch()%>
                                                        </option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                                <div class="col-md-3">

                                                    <div class="md-checkbox">
                                                        <input type="checkbox" id="seall" name="seall" class="md-checkbox" onchange="return valid('seall', 'branch');"> 
                                                        <label for="seall">
                                                            <span></span>
                                                            <span class="check"></span>
                                                            <span class="box"></span> Select All
                                                        </label>
                                                    </div>

                                                </div>
                                            </div>
                                            <hr> 
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Code</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control uppercase" disabled="disabled"> 
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Description</label>
                                            <div class="col-md-9">
                                                <input type="text" class="form-control" id="descr" name="descr" onkeypress="return keysub(this, event);"> 
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-md-3 control-label">Type</label>
                                            <div class="col-md-9">
                                                <input type="checkbox" class="make-switch"
                                                       name="typetill" id="typetill" data-size="normal" data-on-color="primary" data-off-color="info"
                                                       data-on-text="<span class='tabnow'>Safe</span>" 
                                                       data-off-text="<span class='tabnow'>Till</span>" onkeypress="return keysub(this, event);">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
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
                        if (esito.equals("ok")) {
                            classal = "alert-success";
                            classfa = "fa-check";
                            msg = "Success";
                            msg1 = "Operation completed successfully.";
                        } else if (esito.equals("koins")) {
                            classal = "alert-danger";
                            classfa = "fa-exclamation-triangle";
                            msg = "Error";
                            msg1 = "The operation could not be completed.";
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

            <!-- END PAGE LEVEL PLUGINS -->
            <script src="assets/global/scripts/datatable.js" type="text/javascript"></script>
            <script src="assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
            <script src="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>

            <!-- BEGIN THEME GLOBAL SCRIPTS -->
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
                                                                       bStateSave: !0,
                                                                       lengthMenu: [
                                                                           [25, 50, 100, -1],
                                                                           [25, 50, 100, "All"]
                                                                       ],
                                                                       pageLength: 25,
                                                                       columnDefs: [
                                                                           {orderable: !1, targets: [0]},
                                                                           {className: "tabnow", targets: [1]},
                                                                           {searchable: !1, targets: [0]}
                                                                       ],
                                                                       buttons: [
                                                                           {extend: "excel", className: "btn green-jungle btn-outline", text: "<i class='fa fa-file-excel-o'></i> Excel"}]
                                                                       ,
                                                                       colReorder: {reorderCallback: function () {
                                                                               
                                                                           }},
                                                                       order: [],
                                                                       dom: "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><t><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
                                                                       processing: true
                                                                   });
                                                                   $("tfoot input").keyup(function () {
                                                                       e.fnFilter(this.value, e.oApi._fnVisibleToColumnIndex(
                                                                               e.fnSettings(), $("tfoot input").index(this)));
                                                                   });
                                                                   $("tfoot input").each(function (i) {
                                                                       this.initVal = this.value;
                                                                   });
                                                                   $("tfoot input").focus(function () {
                                                                       if (this.className === "form-control")
                                                                       {
                                                                           this.className = "form-control";
                                                                           this.value = "";
                                                                       }
                                                                   });
                                                                   $("tfoot input").blur(function (i) {
                                                                       if (this.value === "")
                                                                       {
                                                                           this.className = "form-control";
                                                                           this.value = this.initVal;
                                                                       }
                                                                   });
                                                               };
                                                               jQuery().dataTable && dt();
                                                           });
            </script>
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
