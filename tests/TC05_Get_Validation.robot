*** Settings ***
Library       Collections
Library       RequestsLibrary
Library       String
Library        DateTime
Library     SeleniumLibrary
Library    Get_CSS_Value.py

*** Variables ***
${base_url}         http://localhost:8080/
${nat_id}
${birthday}
${gender}
${name}
${salary}
${tax}

*** Test Cases ***
As the Bookkeeper, I should be able to query the amount of tax relief for each person in the database so that I can report the figures to my Bookkeeping Manager
       [Tags]      API
      ${get_response}=   GET     ${base_url}/calculator/taxRelief     expected_status=200
      log    ${get_response.json()}
      Log    ${get_response.json()}[0][name]
      Log    ${get_response.json()}[0][tax]
      Should be Equal as Strings     ${nat_id}    ${get_response.json()}[0][natid]
      ${nat_id}=    Remove String        ${nat_id}   ,    $
      ${matches} =	Get Regexp Matches	[0-9](?=.*){4}	${nat_id}

As the Bookkeeper, I should calculate the tax
       [Tags]      API
      ${get_response}=   GET     ${base_url}/calculator/taxRelief     expected_status=200
      log    ${get_response.json()}
      Log    ${get_response.json()}[0][name]
      Log    ${get_response.json()}[0][tax]
      ${age}=  ${get_response.json()}[0][age]
      ${gender}=    ${get_response.json()}[0][gender]
      ${salary}=    ${get_response.json()}[0][salary]
      ${tax}=    ${get_response.json()}[0][tax]
      Should be Equal as Strings     ${nat_id}    ${get_response.json()}[0][natid]
      ${nat_id}=    Remove String        ${nat_id}   ,    $
      ${matches}=	Get Regexp Matches	[0-9](?=.*){4}	${nat_id}
      ${date}=	    Convert Date	${birthday}	date_format=%d.%m.%Y
       Set Variable If   ${age}>18
       ${var} =	Set Variable If	${age}>17 and  ${age}<34  1
       ${var} =	Set Variable If	${age}>34 and  ${age}<49  0.8
       ${var} =	Set Variable If	${age}>49 and  ${age}<74  1
       ${var} =	Set Variable If	${age}==75  0.367
       ${var} =	Set Variable If	${age}==76  0.05


       ${Gender_bonus} =	Set Variable If	${gender}=="Male"  0
       ${Gender_bonus} =	Set Variable If	${gender}=="Female"  500

       ${tax_relief} =	Evaluate	(({salary}-{tax})*{var})+{Gender_bonus}
       Log      ${tax_relief}
       ${result} =	Convert To Number	${tax_relief}	2
As the Governor, I should be able to see a button on the screen so that I can dispense tax relief for my working class heroes
       [Tags]      UI
       Open Browser     ${base_url}
       # ${id}=	Get Element Attribute	xpath://*[@id="contents"]/a[2]	    background-color
       #${STYLE}=    Get Element Attribute    background-color    xpath://*[@id="contents"]/a[2]
       Run Keyword And Ignore Error    Scroll Element Into View    xpath:/html/body/div/div[2]/div/a[2]
       ${Button_Name}=   Value_display_CSS_property
       Element Text Should Be   ${Button_Name}  #dc3545

