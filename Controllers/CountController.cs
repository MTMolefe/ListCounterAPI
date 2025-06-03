using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;


namespace ListCounterAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CountController : ControllerBase
    {
        [HttpPost]
        [Route("count")]
        public IActionResult CountOccurrences([FromBody] InputModel model)
        {
            if (model == null || model.Items == null)
            {
                return BadRequest("Invalid input data");
            }

            var itemCounts = new Dictionary<string, int>();

            foreach (var item in model.Items)
            {
                if (item != null)
                {
                    string key = item.ToString();
                    if (itemCounts.ContainsKey(key))
                    {
                        itemCounts[key]++;
                    }
                    else
                    {
                        itemCounts[key] = 1;
                    }
                }
            }

            return Ok(itemCounts);
        }
    }
}
