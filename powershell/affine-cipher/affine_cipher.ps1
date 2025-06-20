function Encode-AffineCipher {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Text,

        [Parameter(Mandatory = $true)]
        [string]$A,

        [Parameter(Mandatory = $true)]
        [string]$B
    )

    return $result    
}

function Decode-AffineCipher {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Text,

        [Parameter(Mandatory = $true)]
        [int]$A,

        [Parameter(Mandatory = $true)]
        [int]$B
    )


    return $result

}
