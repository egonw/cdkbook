for line in `cat classes.lst` ; do
  echo `find ../cdk -name "$line.java"`
done
