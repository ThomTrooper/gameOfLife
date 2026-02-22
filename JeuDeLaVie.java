import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class JeuDeLaVie extends JPanel implements ActionListener {
    private int lignes = 30;
    private int colonnes = 50;
    private int tailleCellule = 20;
    
    private int[][] matrice;
    private int[][] matriceSuivante;
    private int[] dx = {-1, 0, 1, 1, 1, 0, -1, -1};
    private int[] dy = {-1, -1, -1, 0, 1, 1, 1, 0};

    public JeuDeLaVie() {
        // config fenêtre
        setPreferredSize(new Dimension(colonnes * tailleCellule, lignes * tailleCellule));
        setBackground(Color.BLACK);

        matrice = genMatrice();
        matriceSuivante = genMatrice();
        initMatrice(matrice, 0.5);
        Timer timer = new Timer(333, this);
        timer.start();
    }

    // Génération d'une matrice vide
    private int[][] genMatrice() {
        int[][] nouvelleMatrice = new int[lignes][colonnes];
        for (int i = 0; i < lignes; i++) {
            for (int j = 0; j < colonnes; j++) {
                nouvelleMatrice[i][j] = 0;
            }
        }
        return nouvelleMatrice;
    }

    // Fonction valeur random
    private int valeurRandom(double p) {
        if (Math.random() < p) {
            return 1;
        } else {
            return 0;
        }
    }

    // Initialisation de la matrice
    private void initMatrice(int[][] mat, double proba) {
        for (int i = 0; i < lignes; i++) {
            for (int j = 0; j < colonnes; j++) {
                mat[i][j] = valeurRandom(proba);
            }
        }
    }

    // Compte le nombre de cell voisines vivantes
    private int getNbVoisinsVivant(int x, int y, int[][] mat) {
        int cmpt = 0;

        for (int i = 0; i < dx.length; i++) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx >= 0 && nx < lignes && ny >= 0 && ny < colonnes) {
                if (mat[nx][ny] > 0) {
                    cmpt = cmpt + 1;
                }
            }
        }
        return cmpt;
    }

    private void majEtape() {
        for (int i = 0; i < lignes; i++) {
            for (int j = 0; j < colonnes; j++) {
                int voisins = getNbVoisinsVivant(i, j, matrice);
                int age = matrice[i][j];

                if (age > 0) {
                    // cellule vivante
                    if (voisins == 2 || voisins == 3) {
                        matriceSuivante[i][j] = age + 1;
                    } else {
                        matriceSuivante[i][j] = 0;
                    }
                } else {
                    // cellule morte
                    if (voisins == 3) {
                        matriceSuivante[i][j] = 1;
                    } else {
                        matriceSuivante[i][j] = 0;
                    }
                }
            }
        }
        
        // la prochaine matrice devient la matrice actuelle
        // copie profonde pour éviter les problèmes de référence
        for (int i = 0; i < lignes; i++) {
            for (int j = 0; j < colonnes; j++) {
                matrice[i][j] = matriceSuivante[i][j];
            }
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        majEtape();
        repaint(); // Force l'appel à paintComponent
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        for (int i = 0; i < lignes; i++) {
            for (int j = 0; j < colonnes; j++) {
                int valeur = matrice[i][j];
                
                if (valeur > 0) {
                    if (valeur == 1) {
                        g.setColor(Color.GREEN); // vert
                    } else if (valeur <= 10) {
                        g.setColor(Color.YELLOW); // jaune
                    } else if (valeur <= 20) {
                        g.setColor(Color.RED); // rouge
                    } else {
                        g.setColor(Color.MAGENTA); // magenta
                    }
                } else {
                    g.setColor(new Color(51, 51, 51)); // gris
                }
                
                // Dessin du rectangle
                g.fillRect(j * tailleCellule, i * tailleCellule, tailleCellule - 1, tailleCellule - 1);
            }
        }
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Jeu de la Vie");
        JeuDeLaVie jeu = new JeuDeLaVie();
        frame.add(jeu);
        frame.pack();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }
}