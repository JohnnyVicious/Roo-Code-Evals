BeforeAll {
    . $PSScriptRoot/affine_cipher.ps1
}

Describe "AffineCipher Tests" {
    Context "Encoding Tests" {
        It "Should encode 'yes' correctly" {
            Encode-AffineCipher -Text "yes" -A 5 -B 7 | Should -Be "xbt"
        }

        It "Should encode 'no' correctly" {
            Encode-AffineCipher -Text "no" -A 15 -B 18 | Should -Be "fu"
        }

        It "Should encode 'OMG' correctly" {
            Encode-AffineCipher -Text "OMG" -A 21 -B 3 | Should -Be "lvz"
        }

        It "Should encode 'O M G' correctly" {
            Encode-AffineCipher -Text "O M G" -A 25 -B 47 | Should -Be "hjp"
        }

        It "Should encode 'mindblowingly' correctly" {
            Encode-AffineCipher -Text "mindblowingly" -A 11 -B 15 | Should -Be "rzcwa gnxzc dgt"
        }

        It "Should encode text with numbers correctly" {
            Encode-AffineCipher -Text "Testing,1 2 3, testing." -A 3 -B 4 | Should -Be "jqgjc rw123 jqgjc rw"
        }

        It "Should encode 'Truth is fiction.' correctly" {
            Encode-AffineCipher -Text "Truth is fiction." -A 5 -B 17 | Should -Be "iynia fdqfb ifje"
        }

        It "Should encode all the letters correctly" {
            Encode-AffineCipher -Text "The quick brown fox jumps over the lazy dog." -A 17 -B 33 | Should -Be "swxtj npvyk lruol iejdc blaxk swxmh qzglf"
        }

        It "Should throw error when 'a' is not coprime to 'm'" {
            { Encode-AffineCipher -Text "This is a test." -A 6 -B 17 } | Should -Throw -ExpectedMessage "a and m must be coprime."
        }
    }

    Context "Decoding Tests" {
        It "Should decode 'tytgn fjr' correctly" {
            Decode-AffineCipher -Text "tytgn fjr" -A 3 -B 7 | Should -Be "exercism"
        }

        It "Should decode a sentence correctly" {
            Decode-AffineCipher -Text "qdwju nqcro muwhn odqun oppmd aunwd o" -A 19 -B 16 | Should -Be "anobstacleisoftenasteppingstone"
        }

        It "Should decode text with numbers correctly" {
            Decode-AffineCipher -Text "odpoz ub123 odpoz ub" -A 25 -B 7 | Should -Be "testing123testing"
        }

        It "Should decode all the letters correctly" {
            Decode-AffineCipher -Text "swxtj npvyk lruol iejdc blaxk swxmh qzglf" -A 17 -B 33 | Should -Be "thequickbrownfoxjumpsoverthelazydog"
        }

        It "Should decode text with no spaces in input correctly" {
            Decode-AffineCipher -Text "swxtjnpvyklruoliejdcblaxkswxmhqzglf" -A 17 -B 33 | Should -Be "thequickbrownfoxjumpsoverthelazydog"
        }

        It "Should decode text with too many spaces correctly" {
            Decode-AffineCipher -Text "vszzm    cly   yd cg    qdp" -A 15 -B 16 | Should -Be "jollygreengiant"
        }

        It "Should throw error when 'a' is not coprime to 'm' during decode" {
            { Decode-AffineCipher -Text "Test" -A 13 -B 5 } | Should -Throw -ExpectedMessage "a and m must be coprime."
        }
    }
}
