<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.shop.sys.entities.Category"%>
<%@page import="com.shop.sys.entities.Customer"%>
<%@page import="com.shop.sys.dao.CategoryDao"%>
<%@page import="com.sho.sys.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Test</h1>

        <!-- Button to trigger the removal -->
        <button id="removeFromCartButton">Remove From Cart</button>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const removeFromCartButton = document.getElementById('removeFromCartButton');
                
                
                // Add event listener to the button
                removeFromCartButton.addEventListener('click', function () {
                    // Perform actions when the button is clicked
                    // You can send a request to remove the item from the cart here
                    // For example:
                    fetch('/ShopManagementSystem/RemoveFromCartServlet', {
                        method: 'POST'
                                // Optionally, you can provide data in the request body
                                // body: JSON.stringify({ productId: productId })
                    })
                            .then(response => {
                                // Handle the response as needed
                                if (!response.ok) {
                                    throw new Error('Network Response Was Not ok');
                                }
                                return response.text();
                            })
                            .then(data => {
                                // Process the data returned by the server
                                console.log(data);
                            })
                            .catch(error => {
                                // Handle errors
                                console.error('There was a problem with the fetch operation:', error);
                            });
                });
            });
        </script>
    </body>
</html>
