#include <kgmBase/kgmObject.h>
#include <kgmGame/kgmGameApp.h>
#include <kgmSystem/kgmSystem.h>

#include "kGame.h"

#include <memory>

class kRaser: public kgmGameApp, public kgmObject
{
  KGM_OBJECT(kRaser);

  std::unique_ptr<kGame> game;

public:
  void gameFree()
  {
    if(game)
    {
      game.release();
      game.reset();
    }
  }

  void gameInit()
  {
    u32 w, h;

    kgmSystem::getDesktopDimension(w, h);

    game = std::unique_ptr<kGame>(new kGame());

    kgmGameBase::m_game = (kgmGameBase*) (kGame*) game.get();

    game->gInit();
  }

  void gameLoop()
  {
    if(game != null)
    {
      game->loop();
    }

  }
};

int main(int argc, char** argv)
{
  kRaser app;

  return app.exec(argc, argv);
}
