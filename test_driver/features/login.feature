Feature: Login

    Scenario: 未輸入帳號或密碼
        Given 我正在登入頁面
        When 我點擊登入按鈕
        Then 我應該看到錯誤提示

    Scenario: 輸入正確的帳號及密碼
        Given 我正在登入頁面
        When 我輸入表格內容
            | input      | field |
            | 'username' | 0     |
            | 'password' | 1     |
        And 我點擊登入按鈕
        Then 我應該進入首頁

    Scenario: 輸入錯誤的帳號或密碼
        Given 我正在登入頁面
        When 我輸入表格內容
            | input    | field |
            | 'unknow' | 0     |
            | 'pxxxx'  | 1     |
        And 我點擊登入按鈕
        Then 我應該看到錯誤提示


    Scenario: 未輸入帳號或密碼
        Given 我正在登入頁面
        When 我點擊登入按鈕
        Then 我應該看到錯誤提示

    Scenario: 輸入正確的帳號及密碼
        Given 我正在登入頁面
        When 我輸入表格內容
            | input      | field |
            | 'username' | 0     |
            | 'password' | 1     |
        And 我點擊登入按鈕
        Then 我應該進入首頁

    Scenario: 輸入錯誤的帳號或密碼
        Given 我正在登入頁面
        When 我輸入表格內容
            | input    | field |
            | 'unknow' | 0     |
            | 'pxxxx'  | 1     |
        And 我點擊登入按鈕
        Then 我應該看到錯誤提示