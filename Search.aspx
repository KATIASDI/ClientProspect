using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;

public partial class Search : Page
{
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string folderPath = txtPath.Value.Trim();
            string searchTerm = txtSearch.Value.Trim().ToLower();

            if (string.IsNullOrEmpty(folderPath) || !Directory.Exists(folderPath))
            {
                txtResults.Value = "Chemin invalide ou dossier introuvable.";
                return;
            }

            if (string.IsNullOrEmpty(searchTerm))
            {
                txtResults.Value = "Veuillez entrer un terme à rechercher.";
                return;
            }

            // Récupération des fichiers texte dans le dossier
            string[] files = Directory.GetFiles(folderPath, "*.txt");
            List<string> results = new List<string>();

            foreach (string file in files)
            {
                string content = File.ReadAllText(file).ToLower();
                if (content.Contains(searchTerm))
                {
                    results.Add(Path.GetFileName(file));
                }
            }

            if (results.Count > 0)
            {
                txtResults.Value = "Term found in the following documents:\n" + string.Join("\n", results);
            }
            else
            {
                txtResults.Value = "Aucun document ne contient le terme spécifié.";
            }
        }
        catch (Exception ex)
        {
            txtResults.Value = "Erreur : " + ex.Message;
        }
    }
}
