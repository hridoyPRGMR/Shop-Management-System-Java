<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Responsive Sidebar</title>
        <!-- Link Styles -->
        <link href="CSS/sidebar.css" rel="stylesheet" type="text/css"/>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    </head>
    <body>

        <!-- Scripts -->

        <script>
            $(document).ready(function () {
                // Function to load JSP page into the main content area
                function loadPage(pageUrl) {
                    $.ajax({
                        url: pageUrl,
                        type: 'GET',
                        success: function (response) {
                            $('#main-content').html(response); // Inject the loaded content into main content area
                        },
                        error: function (xhr, status, error) {
                            console.error('Error loading page:', error);
                            $('#main-content').html('<p>Failed to load the page.</p>');
                        }
                    });
                }

                // Load default page when the document is ready
                loadPage('default.jsp');

                // Handle sidebar navigation clicks
                $('.nav-link').click(function (event) {
                    event.preventDefault(); // Prevent default link behavior
                    var pageUrl = $(this).attr('href'); // Get the href attribute of the clicked link
                    loadPage(pageUrl); // Load the corresponding JSP page
                });
            });
        </script>

        <script src="JS/sidebar.js" type="text/javascript"></script>
    </body>
</html>