from fastapi import FastAPI

app = FastAPI()

@app.get("/hello-ec2")
def hello():
    return {"message": "Hello from EC2!"}

