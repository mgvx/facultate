import { CatalogNgPage } from './app.po';
describe('catalog-ng App', function () {
    var page;
    beforeEach(function () {
        page = new CatalogNgPage();
    });
    it('should display message saying app works', function () {
        page.navigateTo();
        expect(page.getParagraphText()).toEqual('app works!');
    });
});
//# sourceMappingURL=/home/radu/files/workspaces/workspace_2017/catalog4/catalog-web/src/main/webapp/e2e/app.e2e-spec.js.map