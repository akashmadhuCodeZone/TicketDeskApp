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
using TicketDesk.Utility.Logger;
using TicketDesk.Utility.Security;

var builder = WebApplication.CreateBuilder(args);

var configuration = builder.Configuration;

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

var connectionString = configuration.GetConnectionString("DefaultConnection");

builder.Services.AddSingleton(new Logger(connectionString));

builder.Services.AddScoped<IAgentDataAccess>(provider =>
    new AgentDataAccess(connectionString, provider.GetRequiredService<Logger>()));
builder.Services.AddScoped<IRegisterationDataAccess>(provider =>
    new RegisterationDataAccess(connectionString, provider.GetRequiredService<Logger>()));
builder.Services.AddScoped<IUserProfileDataAccess>(provider =>
    new UserProfileDataAccess(connectionString, provider.GetRequiredService<Logger>()));
builder.Services.AddScoped<IMasterDataAccess>(provider =>
    new MasterDataAccess(connectionString, provider.GetRequiredService<Logger>()));
builder.Services.AddScoped<ITicketDataAccess>(provider =>
    new TicketDataAccess(connectionString, provider.GetRequiredService<Logger>()));
builder.Services.AddScoped<ILoginDataAccess>(provider =>
    new LoginDataAccess(connectionString, provider.GetRequiredService<Logger>()));

builder.Services.AddScoped<IAgentService, AgentService>();
builder.Services.AddScoped<ILoginService, LoginService>();
builder.Services.AddScoped<IMasterDataService, MasterDataService>();
builder.Services.AddScoped<IRegisterationService, RegisterationService>();
builder.Services.AddScoped<ITicketService, TicketService>();
builder.Services.AddScoped<IUserProfileService, UserProfileService>();

builder.Services.AddScoped<JWTTokenGenerator>();

var jwtSettings = configuration.GetSection("JwtSettings");
var secretKey = jwtSettings["SecretKey"];
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.RequireHttpsMetadata = false;
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

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins", builderCors =>
    {
        builderCors.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

var app = builder.Build();

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
