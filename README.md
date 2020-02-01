# dotBash
#my .bashrc profile    

rm -rf ~/.bash #remove .bash folder in home directory if you have one    
git clone https://github.com/danerwilliams/dotBash.git ~/.bash    
rm ~/.bashrc #remove your existing bashrc    
ln -s ~/.bash/bashrc ~/.bashrc    
source ~/.bashrc    
