from dotenv import load_dotenv
import os

load_dotenv()

print("Dotenv loaded successfully!")
print("Test variable:", os.getenv("MY_ENV_VAR", "Not Set"))
