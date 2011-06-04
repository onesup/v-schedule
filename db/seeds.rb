#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
[
  {:title => "BCG", :series => "1회", :timing => 0,  :least => 18.month, 
    :nip => "", :injection_type => "", :desc => "결핵 예방(피내)" },
    
  {:title => "B형간염",:series => "1차", :timing => 0,        
    :nip => "", :injection_type => "", :desc => "HepB(유전자 재조합)" },
    
  {:title => "B형간염",:series => "2차", :timing => 1.month,  
    :nip => "", :injection_type => "", :desc => "(유전자 재조합)" },
    
  {:title => "B형간염",:series => "3차", :timing => 6.month,  
    :nip => "", :injection_type => "", :desc => "(유전자 재조합)" },
    
  {:title => "DTaP",:series => "1차", :timing => 2.month,  
    :nip => "", :injection_type => "", :desc => "(기초)디티에이피 백신은 디프테리아, 파상품, 백일해 세가지 질병의 복합 백신"},
    
  {:title => "DTaP",:series => "2차", :timing => 4.month,  
    :nip => "", :injection_type => "", :desc => "(기초)디티에이피 백신은 디프테리아, 파상품, 백일해 세가지 질병의 복합 백신" },
    
  {:title => "DTaP",:series => "3차", :timing => 6.month,  
    :nip => "", :desc => "(기초)디티에이피 백신은 디프테리아, 파상품, 백일해 세가지 질병의 복합 백신" },
    
  {:title => "DTaP",:series => "4차", :timing => 15.month, 
    :nip => "", :desc => "(추가)디티에이피 백신은 디프테리아, 파상품, 백일해 세가지 질병의 복합 백신"},
    
  {:title => "DTaP",:series => "5차", :timing => 4.year,   
    :nip => "", :desc => "(추가)디티에이피 백신은 디프테리아, 파상품, 백일해 세가지 질병의 복합 백신"},
    
  {:title => "MMR", :series => "1차", :timing => 1.year,   
    :nip => "", :desc => "홍역, 유행성 이하선염, 풍진"},
    
  {:title => "MMR", :series => "2차", :timing => 4.year,   
    :nip => "", :desc => "홍역, 유행성 이하선염, 풍진"},
    
  {:title => "Td",  :series => "6차", :timing => 11.year,  
    :nip => "", :desc => "디프테리아, 파상품, 백일해(성인용)"},
    
  {:title => "Var", :series => "1회", :timing => 1.year,   
    :nip => "", :desc => "수두"},
    
  {:title => "JEV", :series => "1차", :timing => 1.year,   
    :nip => "", :desc => "일본뇌염(기초-사백신)"},
    
  {:title => "JEV", :series => "2차", :timing => 1.year,   
    :desc => "일본뇌염(기초-사백신)"},
    
  {:title => "JEV", :series => "3차", :timing => 2.year,   
    :desc => "일본뇌염(기초-사백신)"},
    
  {:title => "JEV", :series => "4차", :timing => 6.year,   
    :desc => "일본뇌염(추가-사백신)"},
    
  {:title => "JEV", :series => "5차", :timing => 12.year,  
    :desc => "일본뇌염(추가-사백신)"},
    
  {:title => "폴리오", :series => "1차", :timing => 2.month,  
    :desc => "소아마비(기초)"},
    
  {:title => "폴리오", :series => "2차", :timing => 4.month,  
    :desc => "소아마비(기초)"},
    
  {:title => "폴리오", :series => "3차", :timing => 6.month,  
    :least => 18.month, :desc => "소아마비(기초)"},
    
  {:title => "폴리오", :series => "4차", :timing => 4.year,   :least => 6.year, 
    :desc => "소아마(기초)"}
].each do |data|
  Vaccination.create(data)
end