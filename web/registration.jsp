<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Account</title>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script type='text/javascript'>

        var validate = function () {
            var email = document.getElementById('email').value;
            var reg = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
            if (reg.test(email) == false)
            {
                document.getElementById('email').setCustomValidity('Invalid Email Address');
            }
            else
                {
                document.getElementById('email').setCustomValidity('');
            }
        };

        var passcheck = function () {
            if (document.getElementById('1').value.length < 7)
            {
                document.getElementById('1').setCustomValidity('Length of password should be atleast of 8');
            } else
            {
                document.getElementById('1').setCustomValidity('');
            }
            
            if (document.getElementById('1').value != document.getElementById('2').value)
            {
                document.getElementById('2').setCustomValidity("Password Don't Match");
            } else
            {
                document.getElementById('2').setCustomValidity('');
            }
        };
        
        var checkId = function () {
            var len = document.getElementById('sid').value.length;
        
            if (len < 10 || len > 14)
            {
                document.getElementById('sid').setCustomValidity('Length should be between 10 to 14');
            } else
            {
                document.getElementById('sid').setCustomValidity('');
            }
        }
    </script> 
</head>

<body>

    <div class="container">
        <div class="regbox">
            <img class="avatar" src="img/collaboration.png">
            <h1>Register Account</h1>
            <form action="RegisterServlet" method="post">
                <input type="text" placeholder="First Name" name="FirstName" required />
                <input type="text" placeholder="Middle Name" name="MiddleName" required />
                <input type="text" placeholder="Last Name" name="LastName" required />
                <input type="text" placeholder="Student ID" name="StudentID" id="sid" onkeyup="checkId()" required />
                <input type="text" placeholder="Email Address" id="email" onkeyup="validate()" name="EmailAdd" required />
                <input type="password" placeholder="Password" id="1" name="Password" onkeyup="passcheck();" required />
                <input type="password" placeholder="Confirm Password" id="2" name="Confirm Password" onkeyup="passcheck();" required />

                <p>Date of Birth:</p>
                <input type="date" placeholder="DOB" name="DOB" required />

                <p>Gender:</p>
                <span class="gender"><label>Male</label><input type="radio" id="Male" name="Gender" value="M" /></span>
                <span class="gender"><label>Female</label><input type="radio" id="Female" name="Gender" value="F" /></span>
                <span class="gender"><label>Other</label><input type="radio" id="Other" name="Gender" value="O" /></span>
                
                <input type="submit" value="Register" />
                <a href="login.jsp">Already have Account?</a>
            </form>
        </div>
    </div>
</body>

