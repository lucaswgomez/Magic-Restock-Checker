Add-Type -AssemblyName PresentationCore 
$Out = 0
$StartTime = Get-Date -Format "MM/dd/yyyy HH:mm"
$ie = New-Object -com internetexplorer.application;
$ie.visible = $true
$gmailCred = Get-Credential
$mediaPlayer = New-Object System.Windows.Media.Mediaplayer
$sendMailParams = @{
        From = '$gmailCred.UserName' ## Must be gmail.com
        To = '$gmailCred.UserName'
        Subject = 'Time Spiral Restock'
        Body = 'Time Spiral restock'
        SMTPServer = 'smtp.gmail.com'
        Port = 587
        UseSsl = $true
        Credential = $gmailCred
        }
#https://www.amazon.com/gp/aod/ajax/ref=dp_aod_pn?asin=B0874B5G6M Jumpstart Amazon link
#https://www.amazon.com/gp/aod/ajax/ref=dp_aod_unknown_mbc?asin=B08SSSQHHF TimeSpiral REMASTERED Amazon link
while(1) {
    do {
        Write-Host ("$(Get-Date -Format 'MM/dd/yyyy HH:mm') Nothing yet... Started at $StartTime")
        try {
            $ie.Navigate("https://www.amazon.com/gp/aod/ajax/ref=dp_aod_unknown_mbc?asin=B08SSSQHHF")
            Start-Sleep -s 10
            $inputTags = $ie.Document.body.getElementsByClassName("a-button-input")
    
            for($counter = 0;$counter -le $inputTags.length;$counter++) {
                if ($inputTags[$counter].outerHTML -like '*Add to Cart from seller Amazon.com*') {
                    $Out = 1
                    break
                }
                else{ continue }
            }
        }
        catch {
            Write-Host ("Caught weird error. Retrying...")   
        }
    } while($Out -eq 0)


    while($Out -ne 0) {
        $Out = 0
        Write-Host ("$(Get-Date -Format 'MM/dd/yyyy HH:mm')TIME SPIRAL Currently In Stock") -foreground Green
        $mediaPlayer.Open('C:\Windows\Media\Alarm02.wav')
        $mediaPlayer.Play()
        Send-MailMessage @sendMailParams

        try {
            $ie.Navigate("https://www.amazon.com/gp/aod/ajax/ref=dp_aod_unknown_mbc?asin=B08SSSQHHF")
            Start-Sleep -s 5
            $inputTags = $ie.Document.body.getElementsByClassName("a-button-input")
    
            for($counter = 0;$counter -le $inputTags.length;$counter++) {
                if ($inputTags[$counter].outerHTML -like "*Add to Cart from seller Amazon.com*"){
                    $Out = 1
                    break
                }
                else{ continue }
            }
        }
        catch {
            Write-Host ("Caught weird error. Retrying...")   
        }
    
    }
}














#$ie.document.getElementsByTagName("form") | Select-Object -Index 1
#$ie.document.documentElement.querySelectorAll('[aria-label^="Add to Cart from seller Amazon.com"]')
#/gp/add-to-cart/html/ref=aod_dpdsk_new_0

#$ie.Document.getElementsByTagName('form') | Where-Object { $ie.action -eq '/gp/add-to-cart/html/ref=aod_dpdsk_new_0' }