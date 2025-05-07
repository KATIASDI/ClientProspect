using System.Security.Cryptography;
using System.Text;
using System.Web;

public static class Utils
{
    public static string HashPassword(string password)
    {
        using (MD5 md5 = MD5.Create())
        {
            byte[] bytes = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder builder = new StringBuilder();
            foreach (byte b in bytes)
            {
                builder.Append(b.ToString("x2"));
            }
            return builder.ToString();
        }
    }

    public static void ShowAlert(System.Web.UI.Page page, string title, string message, string icon)
    {
        message = message.Replace("'", "\\'");
        string script = $"Swal.fire(\"{title}\", \"{message}\", \"{icon}\");";
        page.ClientScript.RegisterStartupScript(page.GetType(), "alert", script, true);
    }
}
