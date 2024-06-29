using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using TicketDesk.Core.Interfaces;
using TicketDesk.Core.Interfaces.Agent;
using TicketDesk.Core.Interfaces.Login;
using TicketDesk.Core.Interfaces.MasterData;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.Core.Interfaces.Tickets;
using TicketDesk.Core.Services.Agent;
using TicketDesk.Core.Services.Login;
using TicketDesk.Core.Services.MasterData;
using TicketDesk.Core.Services.Registeration;
using TicketDesk.Core.Services.Tickets;
using TicketDesk.Core.Services.UserProfile;
using TicketDesk.DAL.Domain;
using TicketDesk.DAL.Repository;
using TicketDesk.Utility.Security;

var builder = WebApplication.CreateBuilder(args);

IConfiguration configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
    .Build();

// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "TicketDesk.Server",
        Version = "v1"
    });
});

// Register data access services
builder.Services.AddScoped<RegisterationDataAccess>(sp =>
    new RegisterationDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<LoginDataAccess>(sp =>
    new LoginDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<UserProfileDataAccess>(sp =>
    new UserProfileDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<TicketDataAccess>(sp =>
    new TicketDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<MasterDataAccess>(sp =>
    new MasterDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<AgentDataAccess>(sp =>
    new AgentDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<IAgentDataAccess>(sp =>
    new AgentDataAccess(builder.Configuration.GetConnectionString("DefaultConnection")));


// Register business services
builder.Services.AddScoped<IRegisterationService, RegisterationService>();
builder.Services.AddScoped<ILoginService, LoginService>();
builder.Services.AddScoped<IUserPorofileService, UserProfileService>();
builder.Services.AddScoped<IAgentService, AgentService>();
builder.Services.AddScoped<ITicketService, TicketService>();
builder.Services.AddScoped<IMasterDataService, MasterDataService>();

builder.Services.AddHttpClient("NoSslValidationClient")
    .ConfigurePrimaryHttpMessageHandler(() => new HttpClientHandler
    {
        ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true
    });

// Configure JWT authentication
var jwtSettings = builder.Configuration.GetSection("JwtSettings");
var secretKey = jwtSettings["SecretKey"];
var keyBytes = Encoding.UTF8.GetBytes(secretKey); // Correctly handle the key as UTF8 bytes

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtSettings["Issuer"],
        ValidAudience = jwtSettings["Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(keyBytes)
    };
});

// Register the JWT token service
builder.Services.AddScoped<JWTTokenGenrator>();

// Configure CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins",
        builderCors =>
        {
            builderCors.AllowAnyOrigin()
                       .AllowAnyHeader()
                       .AllowAnyMethod();
        });

});

// Configure distributed memory cache for session management
builder.Services.AddDistributedMemoryCache(); // Add this line to configure in-memory cache

// Configure session
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(600);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

var app = builder.Build();

app.UseDefaultFiles();
app.UseStaticFiles();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage(); // Enable developer exception page for detailed errors
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseRouting(); // Ensure this is added before authentication and authorization

app.UseCors("AllowAllOrigins");

app.UseAuthentication(); // Add this line to enable authentication
app.UseAuthorization();
app.UseSession(); // Add this line to enable session

app.MapControllers();
app.MapFallbackToFile("/index.html");
app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

app.Run();
