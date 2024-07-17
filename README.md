# Infrastructure EKS pour l'Application Sock-Shop

Ce dépôt configure l'infrastructure nécessaire pour un cluster EKS destiné à notre application Sock-Shop. Les scripts Terraform sont connectés à notre console AWS pour provisionner les ressources.

## Scripts de Configuration

### Mise en Place de l'État Distant de Terraform
- **s3.tf** : Stockage du fichier d'état de Terraform et table DynamoDB pour le verrouillage de l'état.
- **backend.tf** : Configuration de la communication avec l'état distant.

### Provisionnement du Cluster EKS
- **eks.tf** : Création du cluster EKS.
- **vpc.tf** : Configuration du réseau (VPC) du cluster.

## Modes d'Emploi

### Option 1 : Développement Local
1. Cloner le dépôt :
   ```sh
   git clone <url-du-repo>
2. Créer ou utiliser une branche de fonctionnalité.
3. Initialiser Terraform et le backend :
   ```sh
      terraform init
4. Créer une pull request à la fin du développement de la fonctionnalité.

### Option 2 : Provisionnement du Cluster
1. Aller dans la section `Actions` de ce dépôt.
2. Choisir le workflow `Terraform Infra Provision`.
3. Lancer le pipeline deux fois :
   - Première exécution :
      - Select action : `allow`
      - Should TF be applied? : `no`
     - controller les logs du `terraform plan` à fin de controller les modifications qui seront effectuées
   - Deuxième exécution :
       - Select action : `allow`
      - Should TF be applied? : `yes`

## Note Importante

Après une session de travail, pensez à supprimer les ressources provisionnées sur le cluster. Pour ce faire :

1. Aller dans la section "Actions" de ce dépôt.
2. Choisir le workflow "Terraform Infra Provision".
3. Lancer le pipeline deux fois :
   - Première exécution :
      - Select action : `destroy`
      - Should TF be applied? : `no`
      - controller les logs du `terraform plan` à fin de controller les modifications qui seront effectuées
   - Deuxième exécution :
      - Select action : `destroy`
      - Should TF be applied? : `yes`

## Liens utiles

[Set up the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

[AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/topic/config-vars.html)

[Connect kubectl to an EKS](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)

[Terraform EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest)

[Terraform VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
