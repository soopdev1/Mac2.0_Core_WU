<%@page import="rc.so.entity.NC_category"%>
<%@page import="rc.so.entity.Branch"%>
<%@page import="rc.so.util.Utility"%>
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
        <title>Mac2.0 - Transaction List NC</title>
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

        <script src="assets/soop/js/moment.js" type="text/javascript"></script>
        <script src="assets/soop/js/controlli.js" type="text/javascript"></script>
        <!-- FANCYBOX -->
        
        <script type="text/javascript" src="assets/soop/js/jquery.fancybox.js?v=2.1.5"></script>
        <link rel="stylesheet" type="text/css" href="assets/soop/css/jquery.fancybox.css?v=2.1.5" media="screen" />
        <script type="text/javascript" src="assets/soop/js/fancy.js"></script>


        <script type="text/javascript">

            function search_ing() {
                var d1 = document.getElementById('d1').value;
                var d2 = document.getElementById('d2').value;
                if (d1 === "" || d2 === "") {
                    document.getElementById('saerchmodbtn').click();
                    return false;
                }
                
                
                
                
                var select1 = document.getElementById("nc_cat1");
                var selected1 = "";
                for (var i = 0; i < select1.length; i++) {
                    if (select1.options[i].selected) {
                        selected1 = selected1 + select1.options[i].value + ";";
                    }
                }
                document.getElementById("nc_cat2").value = selected1; 
            }


            function controllatilloccupato() {
                var occ = "true";
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "Operazioni_test?type=controllaoccupato_till&q=none",
                    success: function (data) {
                        occ = data;
                    }
                });
                if (occ === "true") {
                    document.getElementById('errorlarge').className = document.getElementById('errorlarge').className + " in";
                    document.getElementById('errorlarge').style.display = "block";
                    document.getElementById('errorlargetext').innerHTML = "Warning! Operation not permitted. You have an operation pending (Open/Close, Internal/External transfer), before proceeding you MUST first finish that operation.";
                    return false;
                }
                return true;
            }


            function deltr(va) {
                //alert(va);
            }
        </script>
    </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white" onload="return online();">

        <!-- BEGIN HEADER -->
        <%@ include file="menu/header1.jsp"%>
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN MENU -->
            <%@ include file="menu/menu_li3.jsp"%>
            <!-- END MENU -->
            <%
                String lan_index = (String) session.getAttribute("language");
                lan_index = "IT";
                Etichette et_index = new Etichette(lan_index);
                boolean central = Engine.isCentral();
                ArrayList<Branch> array_branch = Engine.list_branch_completeAFTER311217();
                String cod1 = Engine.getFil()[0];
                Branch br1 = Engine.get_branch(cod1);
                ArrayList<NC_category> array_nc_cat = Engine.list_ALL_nc_category();
            %>

            <div class="modal fade" id="largelogin" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Password request</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-icon">
                                    <i class="fa fa-key font-blue"></i>
                                    <input class="form-control" type="password" autocomplete="off" placeholder="Password" name="password"> 
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <form id="checkpasswordmodal" name="checkpasswordmodal" action="" method="post">
                                <button type="submit" class="btn btn-outline blue"><i class="fa fa-arrow-right"></i> Continue</button>
                                <a class="btn btn-outline red" data-dismiss="modal" onclick="return dismiss('largelogin');"><i class="fa fa-remove"></i> Cancel</a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="errorlarge" tabindex="-1" role="dialog" aria-hidden="true">
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
                            <h3 class="page-title">List <small><b>Transaction No Change</b></small></h3>
                        </div>
                        <div class="col-md-1" style="text-align: right;">
                            <img src="assets/soop/img/logocl.png" alt="" class="img-responsive" style="text-align: right;"/> 
                        </div>
                    </div>
                    <div class="modal fade" id="saerchmod" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Search</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <p>
                                            <b>Warning!</b> You must completed all fields.
                                        </p>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <a class="btn btn-outline red" data-dismiss="modal" onclick="return dismiss('saerchmod');"><i class="fa fa-remove"></i> OK</a>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal fade" id="saerchmod2" tabindex="-1" role="dialog" aria-hidden="true">
                        <button type="button" id="saerchmodbtn" class="" data-toggle="modal" data-target="#saerchmod"></button>
                    </div>

                    <!-- END PAGE TITLE-->
                    <!-- END PAGE HEADER-->
                    <!-- SELECT BUY/SELL -->
                    <%
                        String scode = "r1";
                        if (request.getParameter("search") == null) {
                    %>
                    <form name="f1" method="post" action="transaction_listnc.jsp" onsubmit="return search_ing();">
                        <input type="hidden" name="search" value="<%=scode%>"/>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="portlet box green">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-search"></i> Search</div>
                                        <div class="tools">
                                            <a href="javascript:;" class="collapse"> </a>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <%if (central) {%>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Branch</label>
                                                        <select class="form-control select2-allow-clear" name="branch" id="branch" >
                                                            <option value="" selected="selected"></option>
                                                            <%for (int j = 0; j < array_branch.size(); j++) {%>
                                                            <option value="<%=array_branch.get(j).getCod()%>">
                                                                <%=array_branch.get(j).getCod()%> - <%=array_branch.get(j).getDe_branch()%>
                                                            </option>
                                                            <%}%>

                                                        </select>
                                                    </div>
                                                </div>
                                                <%} else {%>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>Branch</label>
                                                        <input type="text" class="form-control" disabled value="<%=br1.getCod() + " - " + br1.getDe_branch()%>"/>
                                                        <input type="hidden" name="branch" id="branch" value="<%=br1.getCod()%>"/>
                                                    </div>
                                                </div>
                                                <%}%>

                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label>Date From</label>
                                                        <input type="text" class="form-control date-picker" id="d1" name="d1" value="<%=Engine.getNow_filter()%>"/>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="form-group">
                                                        <label>Date To</label>
                                                        <input type="text" class="form-control date-picker" id="d2" name="d2" value="<%=Engine.getNow_filter()%>"/>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-group">
                                                        <label>Category</label>
                                                        <input type="hidden" name="nc_cat1" id="nc_cat2" />
                                                    <select class="form-control select2" multiple id="nc_cat1" name="nc_cat2" placeholder="...">
                                                            <option value="...">All</option>
                                                            <%for (int i = 0; i < array_nc_cat.size(); i++) {%>
                                                            <option value="<%=array_nc_cat.get(i).getGruppo_nc()%>"><%=array_nc_cat.get(i).getGruppo_nc()%> - <%=array_nc_cat.get(i).getDe_gruppo_nc()%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="clearfix"></div>
                                                <div class="col-md-3">
                                                    <div class="form-group">
                                                        <label>&nbsp;</label><p class='ab'></p>
                                                        <button type="submit" class="btn btn-outline dark" ><i class="fa fa-search"></i> Search</button>
                                                        <a href="transaction_listnc.jsp" class="btn btn-outline red" ><i class="fa fa-remove"></i> Cancel</a>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                </form>
                <%} else if (request.getParameter("search").equals("r1")) {

                    ArrayList<String> lincsel = new ArrayList<String>();
                    if (request.getParameterValues("nc_cat2") != null) {
                        lincsel = Utility.formatArrayValues(request.getParameterValues("nc_cat2"));
                    }

                    if (lincsel.isEmpty()) {
                        lincsel.add("...");
                    }


                %>
                <form name="f1" method="post" action="transaction_listnc.jsp" onsubmit="return search_ing();">
                    <input type="hidden" name="search" value="<%=scode%>"/>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet box green">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-search"></i> Search</div>
                                    <div class="tools">
                                        <a href="javascript:;" class="collapse"> </a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <%if (central) {%>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label>Branch ID</label>
                                                    <select class="form-control select2-allow-clear" name="branch" id="branch" >
                                                        <option value="" selected="selected"></option>
                                                        <%for (int j = 0; j < array_branch.size(); j++) {
                                                                String selected = "";
                                                                if (array_branch.get(j).getCod().equals(request.getParameter("branch"))) {
                                                                    selected = "selected";
                                                                }
                                                        %>
                                                        <option <%=selected%> value="<%=array_branch.get(j).getCod()%>"> 
                                                            <%=array_branch.get(j).getCod()%> - <%=array_branch.get(j).getDe_branch()%>
                                                        </option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>  
                                            <%} else {%>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label>Branch</label>
                                                    <input type="text" class="form-control" disabled value="<%=br1.getCod() + " - " + br1.getDe_branch()%>"/>
                                                    <input type="hidden" name="branch" id="branch" value="<%=br1.getCod()%>"/>
                                                </div>
                                            </div>
                                            <%}%>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label>Date From</label>
                                                    <input type="text" class="form-control date-picker" id="d1" name="d1" value="<%=request.getParameter("d1")%>"/>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label>Date To</label>
                                                    <input type="text" class="form-control date-picker" id="d2" name="d2" value="<%=request.getParameter("d2")%>"/>
                                                </div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="form-group">
                                                    <label>Category</label>
                                                    <input type="hidden" name="nc_cat1" id="nc_cat2" />
                                                    <select class="form-control select2" multiple id="nc_cat1"  name="nc_cat2" placeholder="...">
                                                        <%String s1 = "";
                                                            if (lincsel.contains("...")) {
                                                                s1 = "selected";
                                                            }
                                                        %>
                                                        <option <%=s1%> value="...">All</option>
                                                        <%for (int i = 0; i < array_nc_cat.size(); i++) {
                                                                String sel = "";
                                                                if (lincsel.contains(array_nc_cat.get(i).getGruppo_nc())) {
                                                                    sel = "selected";
                                                                }
                                                        %>
                                                        <option <%=sel%> value="<%=array_nc_cat.get(i).getGruppo_nc()%>"><%=array_nc_cat.get(i).getGruppo_nc()%> - <%=array_nc_cat.get(i).getDe_gruppo_nc()%></option>
                                                        <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div class="col-md-3">
                                                <div class="form-group">
                                                    <label>&nbsp;</label><p class='ab'></p>
                                                    <button type="submit" class="btn btn-outline dark"><i class="fa fa-search"></i> Search</button>
                                                    <a href="transaction_listnc.jsp" class="btn btn-outline red" ><i class="fa fa-remove"></i> Cancel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>    

                <div class="row">
                    <div class="col-md-12">


                        <div class="portlet box blue-dark">
                            <div class="portlet-title">
                                <div class="caption">
                                    <i class="fa fa-bar-chart"></i>
                                    <span class="caption-subject">Results</span>
                                </div>
                                <div class="actions"></div>
                            </div>

                            <div class="portlet-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-responsive table-bordered" id="sample_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th class="tabnow" style="width: 150px;">Actions</th>
                                                    <th class="tabnow" style="width: 100px;">Status</th>
                                                    <th class="tabnow" style="width: 80px;">BranchID</th>
                                                    <th class="tabnow" style="width: 100px;">Code</th>
                                                    <th class="tabnow" style="width: 100px;">Date</th>
                                                    <th class="tabnow" style="width: 100px;">Till</th>
                                                    <th class="tabnow" style="width: 100px;">User</th>
                                                    <th class="tabnow" style="width: 100px;">Total</th>
                                                    <th class="tabnow" style="width: 100px;">Quantity</th>
                                                    <th class="tabnow" style="width: 100px;">Price</th>
                                                    <th class="tabnow" style="width: 100px;">Fee</th>
                                                    <th class="tabnow" style="width: 300px;">Category</th>
                                                    <th class="tabnow" style="width: 300px;">Causal</th>
                                                    <th class="tabnow" style="width: 100px;">Client</th>
                                                    <th class="tabnow" style="width: 100px;">Type</th>
                                                    <th class="tabnow" style="width: 100px;">Pos/Bank Account</th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>

                                        </table>
                                    </div>

                                </div>
                            </div>

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
        <!-- END THEME LAYOUT SCRIPTS -->
        <script src="assets/global/scripts/datatable.js" type="text/javascript"></script>
        <script src="assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>

        <script type="text/javascript">
                    jQuery(document).ready(function () {
                        var dt2 = function () {
                            var g = $("#sample_1");
                            g.dataTable({
                                language: {aria: {},
                                    sProcessing: "Process...",
                                    emptyTable: "No results found.",
                                    info: "Show _START_ to _END_ of _TOTAL_ results",
                                    infoEmpty: "No results found.",
                                    infoFiltered: "(filtered to _MAX_ total)",
                                    lengthMenu: "Show _MENU_",
                                    search: "Search:",
                                    zeroRecords: "No results found.",
                                    paginate: {previous: "Prev", next: "Next", last: "Last", first: "First"}},
                                ajax: {
                                    url: "Query?type=transaction_list_nc&d1=<%=request.getParameter("d1")%>&nc_cat1=<%=request.getParameter("nc_cat1")%>&branch=<%=request.getParameter("branch")%>&d2=<%=request.getParameter("d2")%>&search=<%=request.getParameter("search")%>",
                                    dataSrc: "aaData",
                                    type: "GET",
                                    timeout: 12000000
                                },
                                scrollX: true,
                                scrollY: false,
                                columnDefs: [
                                    {orderable: !1, targets: [0]},
                                    {orderable: 1, targets: [1]},
                                    {orderable: 1, targets: [2]},
                                    {orderable: 1, targets: [3]},
                                    {orderable: 1, targets: [4]},
                                    {orderable: 1, targets: [5]},
                                    {orderable: 1, targets: [6]},
                                    {orderable: 1, targets: [7]},
                                    {orderable: 1, targets: [8]},
                                    {orderable: 1, targets: [9]},
                                    {orderable: 1, targets: [10]},
                                    {orderable: 1, targets: [11]},
                                    {orderable: 1, targets: [12]},
                                    {orderable: 1, targets: [13]},
                                    {orderable: 1, targets: [14]}
                                ],
                                initComplete: function (settings, json) {
                                    $('.popovers').popover();

                                },
                                buttons: [
                                    {text: "<i class='fa fa-file-pdf-o'></i> Excel",
                                        className: "btn white btn-outline",
                                        action: function (e, dt, node, config) {

                                            //window.open('Download?type=viewExcel&cod=' + cexcel, '_blank');
                                            window.open('Fileview?type=transactionnc_list&branch=<%=request.getParameter("branch")%>&nc_cat1=<%=request.getParameter("nc_cat1")%>&d1=<%=request.getParameter("d1")%>&d2=<%=request.getParameter("d2")%>&value=excel', '_blank');
                                        }
                                    },
                                    {text: "<i class='fa fa-file-pdf-o'></i> Pdf",
                                        className: "btn white btn-outline",
                                        action: function (e, dt, node, config) {

                                            //window.open('Download?type=viewPdf&cod=' + cpdf, '_blank');
                                            window.open('Fileview?type=transactionnc_list&branch=<%=request.getParameter("branch")%>&nc_cat1=<%=request.getParameter("nc_cat1")%>&d1=<%=request.getParameter("d1")%>&d2=<%=request.getParameter("d2")%>&value=pdf', '_blank');
                                        }
                                    },
                                    {extend: "colvis", className: "btn white btn-outline", text: "Columns"},
                                    {text: "<i class='fa fa fa-refresh'></i>",
                                        className: "btn white btn-outline",
                                        action: function (e, dt, node, config) {
                                            location.reload();
                                        }
                                    }]
                                ,
                                colReorder: {reorderCallback: function () {
                                        
                                    }},
                                lengthMenu: [
                                    [25, 50, 100, -1],
                                    [25, 50, 100, "All"]
                                ],
                                pageLength: 25,
                                order: [],
                                dom: "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><t><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
                                //dom: "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><t><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

                                processing: true
                            });

                        };
                        jQuery().dataTable && dt2();
                    });
                    function dropDownFixPosition(button, dropdown) {
                        var dropDownTop = button.offset().top + button.outerHeight();
                        dropdown.css('top', dropDownTop + "px");
                        dropdown.css('left', button.offset().left + "px");
                    }

        </script>


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
