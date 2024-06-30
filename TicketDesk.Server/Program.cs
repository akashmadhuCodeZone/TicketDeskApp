using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using TicketDesk.Core.Interfaces;
using TicketDesk.Core.Interfaces.Agent;
using TicketDesk.Core.Interfaces.Login;
using TicketDesk.Core.Interfaces.MasterData;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.Core.Interfaces.Tickets;
using TicketDesk.Core.Services;
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

// Setup configuration access
var configuration = builder.Configuration;

// Add controllers and API documentation services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "TicketDesk.Server", Version = "v1" });
    c.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Example: 'Authorization: Bearer {token}'",
        Name = "Authorization",
        In = Microsoft.OpenApi.Models.ParameterLocation.Header,
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });
    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new Microsoft.OpenApi.Models.OpenApiSecurityScheme
            {
                Reference = new Microsoft.OpenApi.Models.OpenApiReference
                {
                    Type = Microsoft.OpenApi.Models.ReferenceType.SecurityScheme,
                    Id = "Bearer"
                },
                Scheme = "oauth2",
                Name = "Bearer",
                In = Microsoft.OpenApi.Models.ParameterLocation.Header,
            },
            new string[] {}
        }
    });
});

// Dependency Injection for data access and services
var connectionString = configuration.GetConnectionString("DefaultConnection");
builder.Services.AddScoped<IAgentDataAccess, AgentDataAccess>(_ => new AgentDataAccess(connectionString));
builder.Services.AddScoped<IRegisterationDataAccess, RegisterationDataAccess>(_ => new RegisterationDataAccess(connectionString));
builder.Services.AddScoped<IUserProfileDataAccess, UserProfileDataAccess>(_ => new UserProfileDataAccess(connectionString));
builder.Services.AddScoped<IMasterDataAccess, MasterDataAccess>(_ => new MasterDataAccess(connectionString));
builder.Services.AddScoped<ITicketDataAccess, TicketDataAccess>(_ => new TicketDataAccess(connectionString));
builder.Services.AddScoped<ILoginDataAccess, LoginDataAccess>(_ => new LoginDataAccess(connectionString));
// Continue adding other data access classes and services
builder.Services.AddScoped<ILoginService, LoginService>();
builder.Services.AddScoped<IUserProfileService, UserProfileService>();
builder.Services.AddScoped<IAgentService, AgentService>();
builder.Services.AddScoped<ITicketService, TicketService>();
builder.Services.AddScoped<IMasterDataService, MasterDataService>();
builder.Services.AddScoped<IRegisterationService, RegisterationService>();

// Register JWT token generator
builder.Services.AddScoped<JWTTokenGenerator>();

// Configure JWT authentication
var jwtSettings = configuration.GetSection("JwtSettings");
var secretKey = jwtSettings["SecretKey"];
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.RequireHttpsMetadata = false; // Consider enabling in production
        options.SaveToken = true;
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = jwtSettings["Issuer"],
            ValidAudience = jwtSettings["Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(secretKey))
        };
    });

// CORS setup for allowing requests from any origin
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins", builderCors =>
    {
        builderCors.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

// Build the application
var app = builder.Build();

// Middleware configuration
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "TicketDesk.Server v1"));
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseCors("AllowAllOrigins");
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
app.Run();
