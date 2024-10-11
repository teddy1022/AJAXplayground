package com.systex.playground.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.systex.playground.model.Member;
import com.systex.playground.service.UserService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Map;

@Component
@WebFilter("/*") 
public class LoginFilter implements Filter {

    @Autowired
    private UserService userService;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String requestURI = httpRequest.getRequestURI();

        httpRequest.setCharacterEncoding("UTF-8");
        httpResponse.setCharacterEncoding("UTF-8");

        // 定義不需要登入的請求路徑
        boolean isLoginRequest = requestURI.equals(httpRequest.getContextPath() + "/login");
        boolean isAjaxLoginRequest = requestURI.equals(httpRequest.getContextPath() + "/ajaxlogin");
        boolean isRegisterRequest = requestURI.equals(httpRequest.getContextPath() + "/register");
        boolean isStaticResource = requestURI.startsWith(httpRequest.getContextPath() + "/styles") ||
                requestURI.startsWith(httpRequest.getContextPath() + "/scripts");

        // 定義要保護的路徑
        boolean isProtectedResource = requestURI.startsWith(httpRequest.getContextPath() + "/lottery") ||
                requestURI.startsWith(httpRequest.getContextPath() + "/guess") ||
                requestURI.equals(httpRequest.getContextPath() + "/") ||
                requestURI.equals(httpRequest.getContextPath() + "/index");

        // 登入驗證
        if (isLoginRequest && "POST".equalsIgnoreCase(httpRequest.getMethod())) {
            handleLogin(httpRequest, httpResponse);
            return;
        }

        // AJAX 登入驗證
        if (isAjaxLoginRequest && "POST".equalsIgnoreCase(httpRequest.getMethod())) {
            handleAjaxLogin(httpRequest, httpResponse);
            return;
        }

        // 攔截
        if (isProtectedResource && (session == null || session.getAttribute("loggedInUser") == null)) {
            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                // AJAX 請求
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.getWriter().write("{\"error\": \"User not authorized\"}");
            } else {
                // 非 AJAX 請求
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            }
            return;
        }

        chain.doFilter(request, response);
    }

    private void handleLogin(HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws IOException, ServletException {
        String username = httpRequest.getParameter("username");
        String password = httpRequest.getParameter("password");

        if (username != null && password != null && userService.validateUserCredentials(username, password)) {
            // 驗證成功
            HttpSession session = httpRequest.getSession(true); 
            Member member = userService.findByUsername(username);
            session.setAttribute("loggedInUser", member);

            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index");
        } else {
            // 驗證失敗
            httpRequest.setAttribute("error", "Invalid username or password.");
            httpRequest.getRequestDispatcher("/login").forward(httpRequest, httpResponse);
        }
    }

    private void handleAjaxLogin(HttpServletRequest httpRequest, HttpServletResponse httpResponse)
            throws IOException {
        // 獲取JSON 
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = httpRequest.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        String jsonString = sb.toString();

        // 解析JSON請求
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> credentials = objectMapper.readValue(jsonString, Map.class);

        String username = credentials.get("username");
        String password = credentials.get("password");

        httpResponse.setContentType("application/json");
        httpResponse.setCharacterEncoding("UTF-8");

        if (username != null && password != null && userService.validateUserCredentials(username, password)) {
            // 成功
            HttpSession session = httpRequest.getSession(true); // 创建新的 session
            Member member = userService.findByUsername(username);
            session.setAttribute("loggedInUser", member);

            httpResponse.getWriter().write("{\"status\": \"success\"}");
        } else {
            // 失敗
            httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            httpResponse.getWriter().write("{\"status\": \"error\", \"message\": \"Invalid username or password\"}");
        }
    }

    @Override
    public void destroy() {
    }
}
