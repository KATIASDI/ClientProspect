using System;
using System.Configuration;
using System.Net.NetworkInformation;
using Oracle.ManagedDataAccess.Client;

namespace PROJETFIN1
{
    public partial class EditClient : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString1"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    string clientId = Request.QueryString["id"];
                    HiddenClientId.Value = clientId;
                    ChargerClient(clientId);
                }
                else
                {
                    Response.Redirect("Process.aspx");
                }
            }
        }

        private void ChargerClient(string clientId)
        {
            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                string query = @"
                    SELECT 
    NOM,
    SECTEUR,
    SOUS_SECTEUR,
    BESOINS,
    NBR_EMPLOYES,
    TYPE_RENCONTRE,
    CANAL_ACQUISITION,
    BLACK_LIST,
    INTERDIT_CHEQUIER,
    DATE_CREATION,
    CAPITAL,
    FORME_JURIDIQUE,
    COMMENTAIRE,
    NUMTEL,
    STATUS,
    EMAIL,
    ID_PROSPECT,
    ADRESSE
FROM CLIENT_PROSPECT
WHERE ID_PROSPECT = :id";

                OracleCommand cmd = new OracleCommand(query, conn);
                cmd.Parameters.Add(new OracleParameter("id", OracleDbType.Int32)).Value = int.Parse(clientId);

                conn.Open();
                OracleDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // TextBox
                    TBNom.Text = reader["NOM"].ToString();
                    TBBesoins.Text = reader["BESOINS"].ToString();
                    TBNumTel.Text = reader["NUMTEL"].ToString();
                    TBAdresse.Text = reader["ADRESSE"].ToString();
                    TBEMAIL.Text = reader["EMAIL"].ToString();

                    // DropDownList - sélection par valeur (si non vide)
                    if (!string.IsNullOrEmpty(reader["SECTEUR"].ToString()))
                        DDLSecteur.SelectedValue = reader["SECTEUR"].ToString();

                    if (!string.IsNullOrEmpty(reader["SOUS_SECTEUR"].ToString()))
                        DDLSSecteur.SelectedValue = reader["SOUS_SECTEUR"].ToString();

                    if (!string.IsNullOrEmpty(reader["NBR_EMPLOYES"].ToString()))
                        DropDownList3.SelectedValue = reader["NBR_EMPLOYES"].ToString();

                    if (!string.IsNullOrEmpty(reader["TYPE_RENCONTRE"].ToString()))
                        TypeRencontreDDL.SelectedValue = reader["TYPE_RENCONTRE"].ToString();

                    if (!string.IsNullOrEmpty(reader["CANAL_ACQUISITION"].ToString()))
                      DropDownList1.SelectedValue = reader["CANAL_ACQUISITION"].ToString();

                    if (!string.IsNullOrEmpty(reader["FORME_JURIDIQUE"].ToString()))
                        DropDownList6.SelectedValue = reader["FORME_JURIDIQUE"].ToString();

                    // CheckBox (pour BLACK_LIST et INTERDIT_CHEQUIER) - supposé être "O" ou "N"
                    string blackListValue = reader["BLACK_LIST"].ToString();
                    if (!string.IsNullOrEmpty(blackListValue))
                    {
                        if (RadioButtonList1.Items.FindByValue(blackListValue) != null)
                        {
                            RadioButtonList1.SelectedValue = blackListValue;  // coche "O" ou "N"
                        }
                        else
                        {
                            RadioButtonList1.ClearSelection(); // aucune sélection si valeur inattendue
                        }
                    }


                    // Float (pour CAPITAL)
                    if (reader["CAPITAL"] != DBNull.Value)
                    {
                        decimal capital = Convert.ToDecimal(reader["CAPITAL"]);
                        TBCapital.Text = capital.ToString("F2"); // 2 décimales
                    }

                   
                }


                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string clientId = HiddenClientId.Value;

            using (OracleConnection conn = new OracleConnection(connectionString))
            {
                string updateQuery = @"
                    UPDATE CLIENT_PROSPECT
                    SET NOM = :nom,
                        SECTEUR = :secteur,
                        SOUS_SECTEUR = :sousSecteur
                    WHERE ID_PROSPECT = :id";

                OracleCommand cmd = new OracleCommand(updateQuery, conn);
                cmd.Parameters.Add("nom", OracleDbType.Varchar2).Value = TBNom.Text;
                cmd.Parameters.Add("secteur", OracleDbType.Varchar2).Value = DDLSecteur.SelectedValue;
                cmd.Parameters.Add("sousSecteur", OracleDbType.Varchar2).Value = DDLSSecteur.SelectedValue;
                cmd.Parameters.Add("id", OracleDbType.Int32).Value = int.Parse(clientId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("Process.aspx?msg=updated");
            }
        }
    }
}
