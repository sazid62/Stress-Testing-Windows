$ErrorActionPreference = "Stop"

g++ code.cpp -o code.exe
g++ gen.cpp -o gen.exe
g++ brute.cpp -o brute.exe

$i = 1
while ($true) {
    Write-Output "Running test $i"

    ./gen.exe $i | Out-File -Encoding ASCII input_file.txt

    Get-Content input_file.txt | ./code.exe | Out-File -Encoding ASCII myAnswer.txt

    Get-Content input_file.txt | ./brute.exe | Out-File -Encoding ASCII correctAnswer.txt

    if (Compare-Object (Get-Content myAnswer.txt) (Get-Content correctAnswer.txt) -SyncWindow 0) {
        Write-Output "`nTest failed on case ${i}"
        Write-Output "==== Failing Test Case ===="
        Get-Content input_file.txt
        Write-Output "==== Your Answer ===="
        Get-Content myAnswer.txt
        Write-Output "==== Expected Answer ===="
        Get-Content correctAnswer.txt
        break
    } else {
        Write-Output "Test $i passed"
    }
    $i++
}
