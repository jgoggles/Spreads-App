class UpdateTeamLogos < ActiveRecord::Migration[5.0]
  def change
    Team.find_by(nickname: "Packers").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/IlA4VGrUHzSVLCOcHsRKgg_96x96.png")
    Team.find_by(nickname: "Bears").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/7uaGv3B13mXyBhHcTysHcA_96x96.png")
    Team.find_by(nickname: "Chiefs").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/5N0l1KbG1BHPyP8_S7SOXg_96x96.png")
    Team.find_by(nickname: "Jaguars").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/HLfqVCxzVx5CUDQ07GLeWg_96x96.png")
    Team.find_by(nickname: "Falcons").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/QNdwQPxtIRYUhnMBYq-bSA_96x96.png")
    Team.find_by(nickname: "Vikings").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/Vmg4u0BSYZ-1Mc-5uyvxHg_96x96.png")
    Team.find_by(nickname: "Titans").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/9J9dhhLeSa3syZ1bWXRjaw_96x96.png")
    Team.find_by(nickname: "Browns").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/bTzlW33n9s53DxRzmlZXyg_96x96.png")
    Team.find_by(nickname: "Bills").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/_RMCkIDTISqCPcSoEvRDhg_96x96.png")
    Team.find_by(nickname: "Jets").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/Rb4y9m3hkTcYVmdl10geqw_96x96.png")
    Team.find_by(nickname: "Ravens").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/1vlEqqoyb9uTqBYiBeNH-w_96x96.png")
    Team.find_by(nickname: "Dolphins").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/1ysKnl7VwOQO8g94gbjKdQ_96x96.png")
    Team.find_by(nickname: "Redskins").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/z_Or7w7bQ_ALmWUNsdd7AQ_96x96.png")
    Team.find_by(nickname: "Eagles").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/s4ab0JjXpDOespDSf9Z14Q_96x96.png")
    Team.find_by(nickname: "Rams").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/UyYc_V_6Vabrvr7ous98_A_96x96.png")
    Team.find_by(nickname: "Panthers").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/4BdHvKq4Iyxsp8WaAbpDuQ_96x96.png")
    Team.find_by(nickname: "Colts").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/zOE7BhKadEjaSrrFjcnR4w_96x96.png")
    Team.find_by(nickname: "Chargers").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/tmQHdnwuMcA9n69f5rBr0w_96x96.png")
    Team.find_by(nickname: "Bengals").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/wDDRqMa40nidAOA5883Vmw_96x96.png")
    Team.find_by(nickname: "Seahawks").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/iVPY42GLuHmD05DiOvNSVg_96x96.png")
    Team.find_by(nickname: "Giants").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/q8qdTYh-OWR5uO_QZxFENw_96x96.png")
    Team.find_by(nickname: "Cowboys").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/-zeHm0cuBjZXc2HRxRAI0g_96x96.png")
    Team.find_by(nickname: "49ers").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/ku3s7M4k5KMagYcFTCie_g_96x96.png")
    Team.find_by(nickname: "Buccaneers").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/cv5_3oTDQB0gT7l0g2gSGg_96x96.png")
    Team.find_by(nickname: "Lions").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/WE1l856fyyHh6eAbbb8hQQ_96x96.png")
    Team.find_by(nickname: "Cardinals").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/5Mh3xcc8uAsxAi3WZvfEyQ_96x96.png")
    Team.find_by(nickname: "Steelers").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/mdUFLAswQ4jZ6V7jXqaxig_96x96.png")
    Team.find_by(nickname: "Patriots").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/z89hPEH9DZbpIYmF72gSaw_96x96.png")
    Team.find_by(nickname: "Texans").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/sSUn9HRpYLQtEFF2aG9T8Q_96x96.png")
    Team.find_by(nickname: "Saints").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/AC5-UEeN3V_fjkdFXtHWfQ_96x96.png")
    Team.find_by(nickname: "Broncos").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/ZktET_o_WU6Mm1sJzJLZhQ_96x96.png")
    Team.find_by(nickname: "Raiders").update(logo: "https://ssl.gstatic.com/onebox/media/sports/logos/QysqoqJQsTbiJl8sPL12Yg_96x96.png")
  end
end
