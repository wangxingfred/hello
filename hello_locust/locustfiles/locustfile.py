import random
from locust import HttpUser, task, between


class QuickStartUser(HttpUser):
    weight = 3
    wait_time = between(5, 9)

    @task
    def version_txt(self):
        self.client.get("/update/res/version_adr.txt")

    # @task
    # def index_page(self):
    #     self.client.get("/hello")
    #     self.client.get("/world")
    #
    # @task(3)
    # def view_item(self):
    #     item_id = random.randint(1, 10000)
    #     self.client.get(f"/item?id={item_id}", name="/item")

    # def on_start(self):
    #     self.client.post("/login", {"username": "foo", "password": "bar"})
