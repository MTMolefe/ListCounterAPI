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
            if (model == null || model.Items == null || model.Items.Length == 0)
            {
                return BadRequest("Null Input data);
            }

            Dictionary<object, int> itemCounts = new Dictionary<object, int>();

            foreach (var item in model.Items)
            {
                if (itemCounts.ContainsKey(item))
                {
                    itemCounts[item]++;
                }
                else
                {
                    itemCounts[item] = 1;
                }
            }

            return Ok(itemCounts);
        }
    }
}
