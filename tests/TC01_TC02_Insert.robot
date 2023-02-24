*** Settings ***
Library       Collections
Library       RequestsLibrary
Suite Setup

*** Variables ***
${base_url}         http://localhost:8080/
${birthday}         01011988
${gender}           Male
${name}             Robert
${natid}            001
${salary}           10000
${tax}              3000
${headers}        {'content-type': 'application/json'}
${User_Id}
${FILE_BUTTON}      *//input[@type="file"]
${File_Path}     ${CURDIR}${/}..\\Data\\Sample_CSV.csv



*** Test Cases ***
As the Clerk, I should be able to insert a single record of working class hero into database via an API

        [Tags]      API
      &{req_body}=  Create Dictionary    birthday=${birthday}   gender=${gender}   name=${name}     natid=${natid}    salary=${salary}   tax=${tax}
       ${response}=     POST        ${base_url}/calculator/insert   json=${req_body}    expected_status=201
        log      ${response.json()}
        Dictionary Should Contain Key     ${response.json()}     ID
         ${User_Id}=    Get From Dictionary     ${response.json()}    ID
         Set Global Variable    ${User_Id}
         log  ${User_Id}
         Should be equal as Strings     successfully added      ${response.json()}[Msg]
         status should be       201     ${response}


As the Clerk, I should be able to insert more than one working class hero into database via an API

        [Tags]      API
      &{req_body}=  Create Dictionary    birthday=${birthday}   gender=${gender}   name=${name}     natid=${natid}    salary=${salary}   tax=${tax}
      ${response}=     POST        ${base_url}/calculator/insertMultiple    json=${req_body}    expected_status=201
        log      ${response.json()}
        Dictionary Should Contain Key     ${response.json()}     ID
         ${User_Id}=    Get From Dictionary     ${response.json()}    ID
         Set Global Variable    ${User_Id}
         log  ${User_Id}
         Should be equal as Strings     successfully added      ${response.json()}[Msg]
         status should be       201     ${response}