using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace TicketDesk.Utility.Security
{
    public class JWTTokenGenrator
    {
        private readonly IConfiguration _configuration;

        public JWTTokenGenrator(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<string> GenerateTokenAsync(string userId, string email, string roles)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings");

            var secretKey = jwtSettings["SecretKey"];
            var issuer = jwtSettings["Issuer"];
            var audience = jwtSettings["Audience"];
            var expiryMinutes = Convert.ToInt32(jwtSettings["ExpiryMinutes"]);

            var keyBytes = Convert.FromHexString(secretKey);
            var securityKey = new SymmetricSecurityKey(keyBytes);
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new List<Claim>
    {
        new Claim(JwtRegisteredClaimNames.Sub, userId),
        new Claim(JwtRegisteredClaimNames.UniqueName, email),
        new Claim(JwtRegisteredClaimNames.Email, email), // Assuming username is the email
        new Claim(ClaimTypes.Role, roles), // Ensure role is added here
        new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
    };

            var token = new JwtSecurityToken(
                issuer: issuer,
                audience: audience,
                claims: claims,
                expires: DateTime.UtcNow.AddMinutes(expiryMinutes),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }


    }
}
