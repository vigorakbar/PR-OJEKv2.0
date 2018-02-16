<%-- 
    Document   : order-complete
    Created on : Nov 8, 2017, 2:22:53 PM
    Author     : Rizky Faramita
--%>

<!--DOCTYPE html>-->
<html>

<!-- code for tabs learned from https://www.w3schools.com/w3css/w3css_tabulators.asp-->

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
                <div class="title-text h2">
                    HOW WAS IT?
                </div>
                <div class="wrapper center">
                    <div class="image review-driver round-wrapper">
                        <?php
                        echo '
                            <img src="'.$pickedDriver['image'].'">
                        ';
                        ?>
                    </div>
                    <div class="review-driver wrapper username">
                        <?php
                        echo '
                            @'.$pickedDriver['username'].'
                        ';
                        ?>
                    </div>
                    <div class="review-driver wrapper name">
                        <?php
                        echo $pickedDriver['name']
                        ?>
                    </div>
                    <div class="review-driver wrapper">
                        <form action="/dashboard/order/createorderhistory.php" method="POST">
                            <div class="star-wrapper review">
                                <span class="star" onclick="rate(1)">&#9733;</span>
                                <span class="star" onclick="rate(2)">&#9734;</span>
                                <span class="star" onclick="rate(3)">&#9734;</span>
                                <span class="star" onclick="rate(4)">&#9734;</span>
                                <span class="star" onclick="rate(5)">&#9734;</span>
                                <input id="rateVal" type="hidden" name="rate" value="1" />
                            </div>
                            <div class="wrapper review">
                                <input class="review" type="text" name="review" placeholder="Your comment...">
                            </div>
                            <div class="button-wrapper review">
                                <div>
                                    <?php
                                echo '
                                    <input type="hidden" name="userId" value="'.$id.'" />
                                    <input type="hidden" name="driverId" value="'.$driverId.'" />
                                    <input type="hidden" name="from" value="'.$from.'" />
                                    <input type="hidden" name="to" value="'.$to.'" />
                                    <input type="hidden" name="orderdate" value="'.$orderdate.'" />'
                                ?>
                                        <input class="review button" type="submit" value="COMPLETE ORDER" />
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
    </div>
</div>
</body>

<script>
    function rate(val) {
        document.getElementById("rateVal").value = val;
        var stars = document.getElementsByClassName("star");
        for (i = 0; i < val; i++) {
            void (stars[i].innerHTML = "&#9733");
        }
        for (i = val; i < 6; i++) {
            void (stars[i].innerHTML = "&#9734");
        }
    }
</script>

</html>
