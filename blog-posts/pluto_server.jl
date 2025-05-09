# File: pluto_server.jl
using Pluto
using HTTP
using Sockets

# Configuration
const PORT = 8080
const HOST = "127.0.0.1"  # Bind to localhost for VPN access

# Optional: Authentication Function
function check_credentials(request)
    # Implement your authentication logic
    # Example: Check for a specific header or token
    auth_header = HTTP.header(request, "Authorization")
    
    # Replace with your actual authentication method
    return !isempty(auth_header) && 
           startswith(auth_header, "Bearer your-secret-token")
end

# Pluto Server Configuration
function start_pluto_server()
    # Server options
    options = Pluto.Configuration(
        host = HOST,
        port = PORT,
        require_auth = true,
        auth_provider = check_credentials,
        launch_browser = false,
        notebook_path = expanduser("~/pluto_notebooks")
    )

    # Start Pluto server
    Pluto.run(options)
end

# Run the server
start_pluto_server()
