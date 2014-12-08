<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="en">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Trader History</title>

    <!-- Bootstrap Core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../css/sb-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="../js/jquery.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="http://www.datejs.com/build/date.js"></script>
<script>
	$(document).ready(function() {
		getTransactionHistory();
		//alert("I have been executed!!!")
	});
	function getTransactionHistory() {	
		$.ajax({
			url: "http://localhost:8080/Msi-Project/app/showHistory.htm",
			type: "post",
			dataType: "json",
			success: showData
		});	
	}
	function showData(data) {
		var rows = "";
		$("#transactions").empty();		
		$(data).each(function(i, item) {
			var sid = item.sid;
			var time = new Date(item.t_time);
			var price = item.price;
			var quantity = item.quantity;
			var type = item.t_type;
			var status = item.t_status;
			rows = "<tr>"+
			       "<td>" + sid + "</td>" +
			       "<td>" + time + "</td>" +
			       "<td>" + price + "</td>" +
			       "<td>" + quantity + "</td>" +
			       "<td>" + type + "</td>" +
			       "<td>" + status + "</td>" +
			       "</tr>";
			$(rows).appendTo("#transactions");
		})		
	}
</script>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/app/dashboard.htm">Yahoo Finance System</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>${shownName}<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/app/profile.htm"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/app/settings.htm"><i class="fa fa-fw fa-gear"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="<c:url value='/j_spring_security_logout'/>"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="${pageContext.request.contextPath}/app/dashboard.htm"><i class="fa fa-fw fa-dashboard"></i> MarketData</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/app/portfolio.htm"><i class="fa fa-fw fa-table"></i> Portfolio</a>
                    </li>
                    <li class="active">
                        <a href="${pageContext.request.contextPath}/app/history.htm"><i class="fa fa-fw fa-table"></i> History</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/app/balance.htm"><i class="fa fa-fw fa-file"></i> Balance</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/app/transaction.htm"><i class="fa fa-fw fa-file"></i> Transaction</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            History
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="${pageContext.request.contextPath}/app/dashboard.htm">MarketData</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> History
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div>
                        <h2>Transaction History</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Stock ID</th>
                                        <th>Time</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Type</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody id="transactions">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="../js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../js/bootstrap.min.js"></script>

</body>

</html>
