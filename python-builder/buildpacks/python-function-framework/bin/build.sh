#!/usr/bin/env bash

set -eo pipefail

# fetch function name from env
if [ -z "$FUNCTION_NAME" ]; then
  echo "ERROR: missing FUNCTION_NAME env var"
  exit 1
fi

# Install the Python dependencies
pip install -r /workspace/requirements.txt

# Copy the framework.py file to the app directory
cp framework.py app/
cp /workspace/app.py app/

# Create the user function with the function name
echo "if __name__ == '__main__':
    fc = FunctionContext($FUNCTION_NAME, 50051)
    fc.load_user_function(user_function)
    fc.run()" > /app/app.py


echo "python /app/app.py" > /cnb/process/web
chmod +x /cnb/process/web
