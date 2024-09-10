8000: This is the default port for proxying HTTP traffic. Clients send requests to this port, and Kong forwards them to the appropriate upstream services based on its configuration.  
Source icon
Source icon

8443: This is the default port for proxying HTTPS traffic. Similar to port 8000, but for secure connections using SSL/TLS.  
Source icon
Source icon

8001: This port is used for the Admin API. You can use this port to interact with Kong programmatically, configuring services, routes, plugins, and other settings. It's important to secure this port in production environments as it provides administrative access to Kong.  
Source icon

8444: This is the HTTPS equivalent of the Admin API port, providing secure access to the Kong Admin API.
  