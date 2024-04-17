function validateRegister() {
    var password = document.getElementById("password").value;
    var repeatPassword = document.getElementById("repeatpassword").value;
    var passwordNotMatchElement = document.getElementById("passwordNotMatch");
    var agreeTermsCheckbox = document.getElementById("checkBox");

    // Check if passwords match
    if (password !== repeatPassword) {
        // Passwords do not match, show error message
        passwordNotMatchElement.style.display = "block";
        return false; // Prevent form submission
    } else {
        // Passwords match, hide error message (if it was previously shown)
        passwordNotMatchElement.style.display = "none";
    }

    // Check if Terms of Service checkbox is checked
    if (!agreeTermsCheckbox.checked) {
        // Terms of Service checkbox is not checked, show alert
        alert("Please agree to the Terms of Service");
        return false; // Prevent form submission
    }

    // All validations passed, allow form submission
    return true;
}
