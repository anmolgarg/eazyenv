PORT=$1
if [ "$PORT" == "" ]; then
    PORT=8889
fi

jupyter lab --port=$PORT --allow-root
