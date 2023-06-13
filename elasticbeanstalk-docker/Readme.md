# Elastic Beanstalk and Docker using Github-pipeline Practice

 ECS is aws's managed container orchestrator and so being an orchestrator it's going to put it in the same family as a Docker swarm or a kubernetes but this is just one that's provided by AWS and is managed by AWS exclusively. ECS is also responsible for deploying and load balancing the application across multiple servers, with Docker or Docker compose it's kind of limited.
 
 Now there are two ways to deploy containers using ECS. ECS + Fargate and ECS + EC2.
 
 ## ECS + Fargate (Setup Guide) - Easy
 
 With ECS Fargate, AWS is now going to manage the underlying infrastructure for me. I’m going to have the ECS control plane and my cluster just like before, but now I’m also going to have this thing called Fargate. It follows a serverless architecture. This means that when I take a look at my cluster, I’m going to see that there are no EC2 instances, there’s nothing there. That’s just like how serverless operates, where there are no physical servers. But when I go and create an application and send it to ECS, what ECS is going to do is it’s going to see that I have no servers to run my application on, so it’s going to talk to Fargate and Fargate will create the servers on demand. It’s going to actually create the underlying resources. Fargate is going to handle all of that and once those instances get created, now ECS can then deploy my containers onto that newly created infrastructure. The great part about this is that I do not need to provision or maintain the EC2 servers. Fargate does all of that for me under the hood and the nice part about this is that I only pay for what I use. So if I delete my application or scale it down, it’s going to remove the underlying resources so I’m not paying for an EC2 server that’s just constantly running all the time.
 
 <img src="./screenshots/fargate.png" alt="Alt text" title="fargate">
 
 ## Screenshots for Fargate (Setup Wizard)-
 
 To use AWS fargate I just followed few easy steps. I switched to old AWS ECS mode and followed steps by clicking get started button.
 
 ### 1
 
 <img src="./screenshots/1.png" alt="Alt text" title="Screenshot 1">
 
 ### 2
 
 <img src="./screenshots/2.png" alt="Alt text" title="Screenshot 2">
 
 ### 3
 
 <img src="./screenshots/3.png" alt="Alt text" title="Screenshot 3">
 
 ### 4
 
 <img src="./screenshots/4.png" alt="Alt text" title="Screenshot 4">
 
 ### 5
 
 <img src="./screenshots/5.png" alt="Alt text" title="Screenshot 5">
 
 ### 6
 
 <img src="./screenshots/6.png" alt="Alt text" title="Screenshot 6">
 
 ### 7
 
 <img src="./screenshots/7.png" alt="Alt text" title="Screenshot 7">
 
 ### 8
 
 <img src="./screenshots/8.png" alt="Alt text" title="Screenshot 8">
 
 
 ## ECS + Fargate (manual)
 
 For this method I'm not going to follow the setup wizard. Though its still gonna use fargate but in this method I have defined how many instances its going to be launched.
 
 ## Screenshots -
 
 ### 1
 
 Here if you notice we have multiple options, since I'm using fargate, I will only select first option
 
 <img src="./screenshots/a1.png" alt="Alt text" title="Screenshot 1">
 
 ### 2
 
 Here I configured cluster name and VPC
 
 <img src="./screenshots/a2.png" alt="Alt text" title="Screenshot 2">
 
 ### 3
 
 <img src="./screenshots/a3.png" alt="Alt text" title="Screenshot 3">
 
 ### 4
 
 In this step I'm going to create Task definition.
 
 <img src="./screenshots/a4.png" alt="Alt text" title="Screenshot 4">
 
 ### 5
 
 I'm using fargate for now, but if I select EC2 I would have to create ec2 instances first and then I had to configured it from ECS.
 
 <img src="./screenshots/a5.png" alt="Alt text" title="Screenshot 5">
 
 ### 6
 
 <img src="./screenshots/a6.png" alt="Alt text" title="Screenshot 6">
 
 ### 7
 
 <img src="./screenshots/a7.png" alt="Alt text" title="Screenshot 7">
 
 ### 8
 
 Here I chose the container and defined the port.
 
 <img src="./screenshots/a8.png" alt="Alt text" title="Screenshot 8">
 
 ### 9
 
 <img src="./screenshots/a9.png" alt="Alt text" title="Screenshot 9">
 
 ### 10
 
 <img src="./screenshots/a10.png" alt="Alt text" title="Screenshot 10">
 
 ### 11
 
 Here I created new service
 
 <img src="./screenshots/a11.png" alt="Alt text" title="Screenshot 11">
 
 ### 12
 
 I defined number of Tasks as 2, in this way it will create 2 instances.
 
 <img src="./screenshots/a12.png" alt="Alt text" title="Screenshot 12">
 
 ### 13
 
 Here I created VPC and selected subnets configured along with vpc.
 
 <img src="./screenshots/a13.png" alt="Alt text" title="Screenshot 13">
 
 ### 14
 
 Here I didn't configure any port just because my application is running on port 80 but if it was running on different port, I would have used custom port.
 
 <img src="./screenshots/a14.png" alt="Alt text" title="Screenshot 14">
 
 ### 15
 
 <img src="./screenshots/a15.png" alt="Alt text" title="Screenshot 15">
 
 ### 16
 
 <img src="./screenshots/a16.png" alt="Alt text" title="Screenshot 16">
 
 ### 17
 
 <img src="./screenshots/a17.png" alt="Alt text" title="Screenshot 17">
 
 ### 18
 
 In this image as you can see there are 2 instances/tasks and they are running on different public IPs. If I want them to run on same IPs I have to implement load balancer and it will automatically balance the traffic amonf the two instances.
 
 <img src="./screenshots/a18.png" alt="Alt text" title="Screenshot 18">
 
 
 Here you can see my portfolio running on 2 different IP Addresses
 
 ### 19
 
 <img src="./screenshots/a19.png" alt="Alt text" title="Screenshot 19">
 
 ### 20
 
 <img src="./screenshots/a20.png" alt="Alt text" title="Screenshot 20">