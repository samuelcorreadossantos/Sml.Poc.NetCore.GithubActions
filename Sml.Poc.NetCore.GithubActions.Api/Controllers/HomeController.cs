using Microsoft.AspNetCore.Mvc;

namespace Sml.Poc.NetCore.GithubActions.Api.Controllers
{
    [ApiController]
    [Route("")]
    public class HomeController : ControllerBase
    {
        [HttpGet]
        public ActionResult<string> Get()
        {
            return Ok("Funcionou :)");
        }
    }
}