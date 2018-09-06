Function New-AWSIAMLabUsers ($users,$group) {
    
    # Loops through the list of users
    $awsusers_hash = foreach($user in $users) {
        
        $aws_userhash = @{}

        # New IAM User
        $aws_userhash.username = $user 
        $aws_userhash.createDate = (New-Iamuser -username $user).CreateDate

        # use random characters to generate the password
        $Password = ([char[]]([char]33..[char]95) + ([char[]]([char]97..[char]126)) + 0..9 | sort {Get-Random})[0..8] -join ''

        # Set the password to the profile in question
        New-IAMLoginProfile -username $user -Password $Password
        
        # Create a new Password for the user
        $aws_userhash.password = $Password

        # Add the user to a particular Group
        Add-IAMUserToGroup -UserName $user -GroupName $group

        $aws_userhash.group = $group

        # Specify the login url for use later
        $aws_userhash.url = $url

        # output the object
        $aws_userhash
    }

    # output the object to the pipeline
    $aws_usershash

}

Function Remove-AWSIAMLabUsers ($users,$group) {
    
    # Loops through the list of users
    foreach($user in $users) {
        
        $aws_userhash = @{}

        # use random characters to generate the password
        $Password = ([char[]]([char]33..[char]95) + ([char[]]([char]97..[char]126)) + 0..9 | sort {Get-Random})[0..8] -join ''

        # Update the profile password in question
        New-IAMLoginProfile -username $user -Password $Password
        
        # Remove the user from a particular Group
        Remove-IAMUserfromGroup -UserName $user -GroupName $group

        # Delete the IAM User

    }


}





