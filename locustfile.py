from locust import HttpUser, task, between

class NginxUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def access_nginx(self):
        self.client.get("/")

# Use this file with locust server to simulate web traffic on the nginx server.