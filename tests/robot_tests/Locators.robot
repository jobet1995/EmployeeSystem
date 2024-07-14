*** Variables ***
${URL}                       http://localhost:8080
${LOGIN_USERNAME_INPUT}      name=username
${LOGIN_PASSWORD_INPUT}      name=password
${LOGIN_BUTTON}              name=login
${DASHBOARD_TITLE}           Dashboard
${ADD_USER_LINK}             link=Add User
${ADD_USER_USERNAME_INPUT}   name=username
${ADD_USER_EMAIL_INPUT}      name=email
${ADD_USER_PASSWORD_INPUT}   name=password
${ADD_USER_BUTTON}           name=add
${USER_SUCCESS_MESSAGE}      User successfully added
${USER_DELETE_BUTTON}        //td[contains(text(),'newuser')]/following-sibling::td/a[text()='Delete']
${USER_DELETE_SUCCESS}       User successfully deleted

${CUSTOMERS_PAGE_LINK}       link=Customers
${ADD_CUSTOMER_BUTTON}       name=add_customer
${CUSTOMER_NAME_INPUT}       name=customer_name
${CUSTOMER_EMAIL_INPUT}      name=customer_email
${CUSTOMER_PHONE_INPUT}      name=customer_phone
${CUSTOMER_SAVE_BUTTON}      name=save_customer
${CUSTOMER_SUCCESS_MESSAGE}  Customer successfully added
${CUSTOMER_DELETE_BUTTON}    //td[contains(text(),'newcustomer')]/following-sibling::td/a[text()='Delete']
${CUSTOMER_DELETE_SUCCESS}   Customer successfully deleted

${ORDERS_PAGE_LINK}          link=Orders
${ADD_ORDER_BUTTON}          name=add_order
${ORDER_CUSTOMER_SELECT}     name=order_customer
${ORDER_AMOUNT_INPUT}        name=order_amount
${ORDER_SAVE_BUTTON}         name=save_order
${ORDER_SUCCESS_MESSAGE}     Order successfully added
${ORDER_DELETE_BUTTON}       //td[contains(text(),'neworder')]/following-sibling::td/a[text()='Delete']
${ORDER_DELETE_SUCCESS}      Order successfully deleted

${LOADING_SPINNER}           id=loadingSpinner
${ERROR_MESSAGE}             class=error-message
${SUCCESS_MESSAGE}           class=success-message