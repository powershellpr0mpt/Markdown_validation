[CmdletBinding()]
param (
    [Parameter()]
    [ValidateScript({Test-Path -Path $_})]
    [string]$FolderPath = 'Git:\Random\DevOps\MarkdownCheck\Correct',
    [Parameter()]
    [string]$Filter = '*.md'
)

#Git:\Random\DevOps\MarkdownCheck\Correct

$Files = Get-ChildItem -Path $FolderPath -Filter $Filter
#$file = $files[0]

Describe -Name 'Markdown validation' {

    $regex_yaml_line_1and5 = '^---$'
    $regex_title_line_2 = '^title:.\w+.*$'
    $regex_author_line_3 = '^author:.\w+.*$'
    $regex_version_line_4 = '^version:.\w+.*$'
    $regex_line_6and8 = '^$'
    $regex_toc_line_7 = '^\[\[_TOC_]]$'

    foreach ($file in $Files){
        Context "Checking file '$($file.Name)'" {
            $content = Get-Content -Path $file.FullName | Select-Object -First 8

            It "1st line should be YAML open tags" {
                $content[0] -match $regex_yaml_line_1and5 | Should -Be $true
            }
            It "2nd line should be title key/value pair" {
                $content[1] -match $regex_title_line_2 | Should -Be $true
            }
            It "3rd line should be author key/value pair" {
                $content[2] -match $regex_author_line_3 | Should -Be $true
            }
            It "4th line should be version key/value pair" {
                $content[3] -match $regex_version_line_4 | Should -Be $true
            }
            It "5th line should be YAML close tags" {
                $content[4] -match $regex_yaml_line_1and5 | Should -Be $true
            }
            It "6th line should be a blank line" {
                $content[5] -match $regex_line_6and8 | Should -Be $true
            }
            It "7th line should be table of contents tags" {
                $content[6] -match $regex_toc_line_7 | Should -Be $true
            }
            It "8th line should be a blank line" {
                $content[7] -match $regex_line_6and8 | Should -Be $true
            }
        }
    }
}