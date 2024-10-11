document.addEventListener("DOMContentLoaded", function () {
    const loginButton = document.getElementById("loginButton");

    loginButton.addEventListener("click", function () {
        const username = document.getElementById("username").value;
        const password = document.getElementById("password").value;

        // AJAX fetch
        fetch('/playground/ajaxlogin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            credentials: 'include', // Ensure cookies are included to maintain session
            body: JSON.stringify({
                username: username,
                password: password
            })
        })
        .then(response => {
            if (response.status === 401) {
                throw new Error('Invalid username or password');
            }
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.status === 'success') {
                // 隱藏網頁中 login 和 register link 避免額外的同步操作
                document.getElementById("switchToStandardLogin").style.display = 'none';
                document.getElementById("registerLink").style.display = 'none';

                // 跟新 navbar，展示 welcome 訊息
                document.getElementById("registerButton").style.display = 'none';
                document.getElementById("usernameDisplay").innerText = username;
                document.getElementById("welcomeUser").style.display = 'inline';

                document.getElementById("loginSuccess").innerText = 'Login successful! Redirecting...';
                document.getElementById("loginSuccess").style.display = 'block';
                document.getElementById("loginError").style.display = 'none';

                // Delay 2 秒，增加與使用者的互動
                setTimeout(() => {
                    window.location.href = '/playground/index';
                }, 2000);
            } else {
                document.getElementById("loginError").innerText = data.message;
                document.getElementById("loginError").style.display = 'block';
                document.getElementById("loginSuccess").style.display = 'none';
            }
        })
        .catch(error => {
            // fetch failed 的情況
            document.getElementById("loginError").innerText = error.message;
            document.getElementById("loginError").style.display = 'block';
            document.getElementById("loginSuccess").style.display = 'none';
        });
    });
});
