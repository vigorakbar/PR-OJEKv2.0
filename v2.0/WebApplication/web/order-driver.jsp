<%-- 
    Document   : order-driver
    Created on : Nov 8, 2017, 1:19:40 PM
    Author     : Rizky Faramita
--%>

<!--DOCTYPE html>-->
<html>

<!-- code for tabs learned from https://www.w3schools.com/w3css/w3css_tabulators.asp -->

<head>
    <title>ORDER</title>
    <meta charset="UTF-8">
    <meta name="description" content="order an OJEK">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/order.css">
</head>

<body>
<div id="outer-wrapper">
    <div id="inner-wrapper">
        <div id="title" class="wrapper">
            <h2>MAKE AN ORDER</h2>
        </div>

        <div id="tab" class="wrapper">
            <div id="destination" class="left tab-item">
                <div class="circle">
                    1
                </div>
                <p class="tab-message">
                    Select Destination
                </p>
            </div>

            <div id="select" class="middle tab-item">
                <div class="circle">
                    2
                </div>
                <p class="tab-message">
                    Select a Driver
                </p>
            </div>

            <div id="complete" class="right tab-item">
                <div class="circle">
                    3
                </div>
                <p class="tab-message">
                    Complete your order
                </p>
            </div>
        </div>

    <script>
        function activateOrderTab(step) {
            switch (step) {
                case 1:
                    document.getElementById("destination").classList.add("active");
                    break;
                case 2:
                    document.getElementById("select").classList.add("active");
                    break;
                case 3:
                    document.getElementById("complete").classList.add("active");
                    break;
                default:
                    break;
            }
        }
    </script>

            <div id="content" class="wrapper">

                <div class="drivers wrapper">
                    <div class="wrapper">
                        <div class="title-text h2">
                            Preferred Drivers
                        </div>
                    </div>
                    <div class="driver-content wrapper ">

                        <?php
                        $driverList = $preferredDrivers;
                        if (!empty($driverList)) {
                            foreach($driverList as $driver) {
                                include('inc-driver-card.jsp');
                            }
                        } else {
                            echo '
                            <div class="wrapper center nothing">
                                Nothing to display :(
                            </div>
                            ';
                        } 
                        ?>

                    </div>
                </div>

                <div class="drivers wrapper">
                    <div class="wrapper">
                        <div class="title-text h2">
                            Other Drivers
                        </div>
                    </div>
                    <div class="driver-content wrapper ">

                        <?php 
                        $driverList = $otherDrivers;
                        if (!empty($driverList)) {
                            foreach($driverList as $driver) {
                                include('inc-driver-card.html');
                            }
                        } else {
                            echo '
                            <div class="wrapper center nothing">
                                Nothing to display :(
                            </div>
                            ';
                        } 
                        ?>

                    </div>
                </div>
            </div>
    </div>
</div>
</body>

</html>
